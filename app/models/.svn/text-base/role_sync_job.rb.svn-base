class RoleSyncJob < SyncJob 
  has_many :role_sync_job_run_logs, :foreign_key => "agent_id", :dependent => :destroy

  alias_attribute :run_logs, :role_sync_job_run_logs

  def self.log_result(job, log)
    @l = RoleSyncJobRunLog.create(:log => log)
    job.run_logs << @l
  end
end
