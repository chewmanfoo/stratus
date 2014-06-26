class DeploymentTiming < ActiveRecord::Base
  attr_accessible :deployment_id, :event, :state

  belongs_to :deployment

#**********************************************************************************
# Scopes
#**********************************************************************************
  
  scope :by_deployment_id, lambda{|i| where(deployment_id: i) }
  scope :by_state, lambda{|s| where(state: s) }
  scope :by_deployment_id_by_state, lambda{ |i,s| where(deployment_id: i, state: s)}

  def name
    "#{state}: #{event} at #{created_at.to_s(:pretty)} for Deployment # #{deployment_id}"
  end

end
