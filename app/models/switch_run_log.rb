class SwitchRunLog < RunLog
  belongs_to :switch, :foreign_key => "agent_id"
end
