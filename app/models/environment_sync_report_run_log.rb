class EnvironmentSyncReportRunLog < RunLog
  belongs_to :environment_sync_report, :foreign_key => "agent_id"
end
