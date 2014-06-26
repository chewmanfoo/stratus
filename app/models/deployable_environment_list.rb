class DeployableEnvironmentList < ActiveRecord::Base
  attr_accessible :environment_id, :system_configuration_id

  belongs_to :environment
  belongs_to :system_configuration
end
