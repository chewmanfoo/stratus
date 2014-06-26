class OosEnvironmentList < ActiveRecord::Base
  attr_accessible :deployment_plan_id, :environment_id

  belongs_to :deployment_plan
  belongs_to :environment
end
