class DeploymentRunLog < RunLog
  belongs_to :deployment, :foreign_key => "agent_id"
end
