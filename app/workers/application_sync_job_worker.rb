class ApplicationSyncJobWorker < GenericWorker
  require 'tmpdir'
  require 'csv'
  require 'yaml'

  def do_perform(job_id)
    @job = ApplicationSyncJob.find(job_id)
  
    @environment = @job.environment
    @environment_url = "#{@environment.svn_path}/#{@environment.svn_file}"

# grab @environment into CSV
    Dir.mktmpdir do |dir|
      @task = "svn co #{@environment.svn_path} #{dir}"

      raise UnixFailedExitException, "Couldn't download environment: [#{@environment.svn_path}]" unless perform_unix("ApplicationSyncJobWorker", @job, @task)
  
      @environment_array = CSV.read("#{dir}/#{@environment.svn_file}")
      @target_pkg_set = Application.all.map(&:name).to_set
      @environment_pkg_set = @environment_array.map {|e| e[0]}.to_set
      @target_version_set = Application.all.map(&:version).to_set 
      @environment_ver_set = @environment_array.map {|e| e[1]}.to_set

      @environment_hash = Hash[@environment_array.map { |k,*v| [k,v] }]

      unless @environment_hash.size == @environment_array.size
        exceptions_str = "environment: we've lost some records in the array -> hash conversion (duplicates)"
        @lost_environment_keys = @environment_array.group_by { |(k,v)| k }.select { |_,v| v.count > 1 }.keys
        exceptions_str << "\n[#{@lost_environment_keys}] were dropped" 
        @job.update_attribute(:exceptions, exceptions_str)
        @job.save
      end

      unless @target_pkg_set == @environment_pkg_set || @target_pkg_set.empty? || @environment_pkg_set.empty?
# for every record in @environment but not in @target, insert into @target 
        @environment_addition = @environment_pkg_set - @target_pkg_set
        logger.info "***********************************************************************************"
        logger.info "records in environment not in target"
        logger.info "#{@environment_addition.inspect}"  
        @environment_addition.each do |a|
          p = Application.find_or_create_by_name(:name => a, :version => @environment_hash[a][0])
        end
      end
    end
    
    @job.complete!
  end
end
