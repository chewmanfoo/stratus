class ApplicationSyncJob < SyncJob 

  has_many :application_sync_job_run_logs, :foreign_key => "agent_id", :dependent => :destroy

  validates :environment_id, :presence => true
  validate :must_be_deployable_environment

  alias_attribute :run_logs, :application_sync_job_run_logs

  def self.log_result(job, log)
    @l = ApplicationSyncJobRunLog.create(:log => log)
    job.run_logs << @l
  end

protected
  def must_be_deployable_environment
    if !(SystemConfiguration.in_effect.deployable_environments.include?(environment))
      errors.add(:environment, "must be deployable")
    end
  end
end
