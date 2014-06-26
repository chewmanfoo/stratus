class AddUseBatchGroupForOosToDeploymentPlans < ActiveRecord::Migration
  def change
    add_column :deployment_plans, :use_batch_group_for_oos, :boolean, :default => true
  end
end
