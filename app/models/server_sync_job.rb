class ServerSyncJob < SyncJob 
  has_many :server_sync_job_run_logs, :foreign_key => "agent_id", :dependent => :destroy

  alias_attribute :run_logs, :server_sync_job_run_logs

  def self.log_result(job, log)
    @l = ServerSyncJobRunLog.create(:log => log)
    job.run_logs << @l
  end
end
