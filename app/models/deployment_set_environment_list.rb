class DeploymentSetEnvironmentList < ActiveRecord::Base
  attr_accessible :deployment_set_id, :environment_id

  belongs_to :deployment_set
  belongs_to :environment
end
