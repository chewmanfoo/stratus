class ServerSyncJobRunLog < RunLog
  belongs_to :server_sync_job, :foreign_key => "agent_id"
end
