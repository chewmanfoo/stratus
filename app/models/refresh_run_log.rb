class RefreshRunLog < RunLog
  belongs_to :refresh, :foreign_key => "agent_id"
end
