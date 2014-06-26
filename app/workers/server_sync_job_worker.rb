class ServerSyncJobWorker < GenericWorker
  require 'tmpdir'
  require 'csv'
  require 'yaml'

  def do_perform(job_id)
    @job = ServerSyncJob.find(job_id)
    @servers_path = "http://#{SVN_SERVER}/#{PUPPET_PATH}/configuration/servers"
 
# grab @servers into CSV
    Dir.mktmpdir do |dir|
      @task = "svn co #{@servers_path} #{dir}"

      raise UnixFailedExitException, "Couldn't download servers: [#{@servers.svn_path}]" unless perform_unix("ServerSyncJobWorker", @job, @task)
  
      @svn_servers_array = CSV.read("#{dir}/servers.csv")
      @target_servers_set = Server.all.map(&:name).to_set
      @svn_servers_set = @svn_servers_array.map {|e| e[0].split('|')[0].strip}.to_set
      @svn_servers_hash = Hash.new
      CSV.foreach(@file, :headers => true,:col_sep => " | ") do |row|
logger.info "for server #{row.field("p_certname")}"
        @svn_servers_hash[row.field("p_certname")] = row.to_csv.split(',')
      end
logger.info("*************svn_servers_array**********************************************")
logger.info("size: #{@svn_servers_array.size}")
logger.info("*************target_servers_set**********************************************")
logger.info("size: #{@target_servers_set.size}")
logger.info("*************svn_servers_set**********************************************")
logger.info("size: #{@svn_servers_set.size}")
logger.info("*************svn_servers_hash**********************************************")
logger.info("size: #{@svn_servers_hash.size}")

      unless @target_servers_set == @svn_servers_set || @svn_servers_set.empty?
# for every record in @servers but not in @target, insert into @target 
        @servers_addition = @svn_servers_set - @target_servers_set
        logger.info "***********************************************************************************"
        logger.info "records in servers not in target"
        logger.info "#{@servers_addition.inspect}"  
        @servers_addition.each do |a|
          row = @svn_servers_hash[a]
          logger.info "***********************************************************************************"
          logger.info "row = #{row}"
          logger.info "***********************************************************************************"

          rid = Role.find_by_name(row[1])
          eid = Environment.find_by_name(row[3])
          unless rid.blank?
            p = Server.find_or_create_by_name(:name => a, 
                                              :role_id => rid, 
                                              :runtime_env => row[2], 
                                              :environment_id => eid, 
                                              :classes => row[4], 
                                              :switches => row[5], 
                                              :sub_runtime_env => row[6], 
                                              :batch_group => row[7])
          end
        end
      end
    end
    
    @job.complete!
  end
end
