class EnvironmentSyncReportWorker < GenericWorker
  require 'tmpdir'
  require 'csv'
  require 'yaml'

  def do_perform(esr_id)
    @esr = EnvironmentSyncReport.find(esr_id)
  
    @trusted = @esr.trusted_environment
    @target = @esr.target_environment
    @work_to_perform = @esr.work_to_perform
    @trusted_url = "#{@trusted.svn_path}/#{@trusted.svn_file}"
    @target_url = "#{@target.svn_path}/#{@target.svn_file}"

# grab @trusted into CSV
    Dir.mktmpdir do |dir|
      @task = "svn co #{@trusted.svn_path} #{dir}"

      raise UnixFailedExitException, "Couldn't download trusted: [#{@trusted.svn_path}]" unless perform_unix("EnvironmentSyncReportWorker", @esr, @task)
  
      @trusted_array = CSV.read("#{dir}/#{@trusted.svn_file}")
#      @trusted_set = Set.new(CSV.read("#{dir}/#{@trusted.svn_file}"))
      @trusted_pkg_set = @trusted_array.map {|e| e[0]}.to_set 
      @trusted_ver_set = @trusted_array.map {|e| e[1]}.to_set

# grab @target into CSV
      Dir.mktmpdir do |dir|
        @task = "svn co #{@target.svn_path} #{dir}"

        raise UnixFailedExitException, "Couldn't download target: [#{@target.svn_path}]" unless perform_unix("EnvironmentSyncReportWorker", @esr, @task)

        @target_array = CSV.read("#{dir}/#{@target.svn_file}")
#        @target_set = Set.new(CSV.read("#{dir}/#{@target.svn_file}"))
         @target_pkg_set = @target_array.map {|e| e[0]}.to_set 
         @target_ver_set = @target_array.map {|e| e[1]}.to_set

      end      
    end
  
    @trusted_hash = Hash[@trusted_array.map { |k,*v| [k,v] }]
    @target_hash = Hash[@target_array.map { |k,*v| [k,v] }]

    @esr.proceed!

#TODO put this in the report

    unless @trusted_hash.size == @trusted_array.size
      logger.info "trusted: we've lost some records in the array -> hash conversion (duplicates)"
      @lost_trusted_keys = @trusted_array.group_by { |(k,v)| k }.select { |_,v| v.count > 1 }.keys
      logger.info "[#{@lost_trusted_keys}] were dropped" 
    end

    unless @target_hash.size == @target_array.size
      logger.info "target: we've lost some records in the array -> hash conversion (duplicates)"
      @lost_target_keys = @target_array.group_by { |(k,v)| k }.select { |_,v| v.count > 1 }.keys
      logger.info "[#{@lost_target_keys}] were dropped" 
    end

    unless @target_pkg_set == @trusted_pkg_set || @target_pkg_set.empty? || @trusted_pkg_set.empty?
# for every record in @trusted but not in @target, EsrPackageProblem.create(:environment_sync_report_id => @esr.id, :package_id => p, :conflict => "belongs to trusted but not target")
      @trusted_addition = @trusted_pkg_set - @target_pkg_set
      logger.info "***********************************************************************************"
      logger.info "records in trusted not in target"
      logger.info "#{@trusted_addition.inspect}"  
      @trusted_addition.each do |a|
        p = Application.find_or_create_by_name(:name => a, :version => @trusted_hash[a][0])
        e = EsrPackageProblem.create(:environment_sync_report_id => @esr.id, :package_id => p.id, 
                                     :trusted_version => @trusted_hash[a][0], :conflict => "belongs to trusted but not target")
        e.save
      end
    
# for every record in @target but not in @trusted, EsrPackageProblem.create(:environment_sync_report_id => @esr.id, :package_id => p, :conflict => "belongs to target but not trusted")
      @target_addition = @target_pkg_set - @trusted_pkg_set
      logger.info "***********************************************************************************"
      logger.info "records in target not in trusted"
      logger.info "#{@target_addition.inspect}"  
      @target_addition.each do |a|
        p = Application.find_or_create_by_name(:name => a, :version => @target_hash[a][0])
        e = EsrPackageProblem.create(:environment_sync_report_id => @esr.id, :package_id => p.id, :target_version => @target_hash[a][0], :conflict => "belongs to target but not trusted")
        e.save
      end

logger.info "got here"

# for every record in @trusted with higher version than @target, EsrPackageProblem.create(:environment_sync_report_id => @esr.id, :package_id => p, :conflict => "trusted version is higher")
# for every record in @target with higher version than @trusted, EsrPackageProblem.create(:environment_sync_report_id => @esr.id, :package_id => p, :conflict => "target version is higher")   
      @trusted_hash.each do |k,v|
logger.info "#{k} and #{v} compared"
logger.info "v[0]: #{v[0]}"        
        unless @trusted_addition.include?(k)
          unless v[0].nil?
            target_v = @target_hash[k][0]
logger.info "target_v: #{target_v}"
            unless v[0] == target_v
              if target_v.nil?
                c = "trusted version is higher"  
              else
                c = v[0] > target_v ? "trusted version is higher" : "target version is higher"
              end
              p = Application.find_or_create_by_name(:name => k, :version => v[0])
              e = EsrPackageProblem.create(:environment_sync_report_id => @esr.id, :package_id => p.id, :trusted_version => v[0], :target_version => target_v, :conflict => c)
              e.save
            end
          end
        end
      end
    end

    @esr.proceed!

# deal with work_to_perform
    
    @esr.complete!
  end

end
