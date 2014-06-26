class RoleSyncJobWorker < GenericWorker
  require 'tmpdir'
  require 'csv'
  require 'yaml'

  def do_perform(job_id)
    @job = RoleSyncJob.find(job_id)
    @roles_path = "http://#{SVN_SERVER}/#{PUPPET_PATH}/configuration/servers"
    @target_role_set = Role.all.map(&:name).to_set
logger.info("******target_role_set*********************************************************************")
logger.info("#{@target_role_set.to_yaml}")  
# grab @role into CSV
    Dir.mktmpdir do |dir|
      @task = "svn co #{@roles_path} #{dir}"

      raise UnixFailedExitException, "Couldn't download servers file: [#{@servers_path}]" unless perform_unix("RoleSyncJobWorker", @job, @task)
  
      @role_array = CSV.read("#{dir}/system-roles.csv")
      @svn_role_set = @role_array.map {|e| e[0]}.to_set
logger.info("*******svn_role_set********************************************************************")
logger.info("#{@svn_role_set.to_yaml}")  

#      unless @svn_role_set.size == @target_role_set.size
#        exceptions_str = "roles: we've lost some records in the array -> hash conversion (duplicates)"
#        @lost_role_keys = @role_array.group_by { |(k,v)| k }.select { |_,v| v.count > 1 }.keys
#        exceptions_str << "\n[#{@lost_role_keys}] were dropped" 
#        @job.update_attribute(:exceptions, exceptions_str)
#        @job.save
#      end

      unless @target_role_set == @svn_role_set || @target_role_set.empty? || @svn_role_set.empty?
# for every record in @svn but not in @target, insert into @target 
        @role_addition = @svn_role_set - @target_role_set
        logger.info "***********************************************************************************"
        logger.info "records in role not in target"
        logger.info "#{@role_addition.inspect}"  
        @role_addition.each do |a|
          p = Role.find_or_create_by_name(:name => a)
        end
      end
    end
    
    @job.complete!
  end
end
