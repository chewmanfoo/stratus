class DeploymentSetRoleList < ActiveRecord::Base
  attr_accessible :deployment_set_id, :role_id

  belongs_to :deployment_set
  belongs_to :role
end
