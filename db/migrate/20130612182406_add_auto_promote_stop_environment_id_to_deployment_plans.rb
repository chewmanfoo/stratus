class AddAutoPromoteStopEnvironmentIdToDeploymentPlans < ActiveRecord::Migration
  def change
    add_column :deployment_plans, :auto_promote_stop_environment_id, :integer
  end
end
