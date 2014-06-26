class DeploymentRequestRunLog < RunLog
  belongs_to :deployment_request, :foreign_key => "agent_id"
end
