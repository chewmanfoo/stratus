class AddCheckoutBinariesToDeploymentPlans < ActiveRecord::Migration
  def change
    add_column :deployment_plans, :run_pre_checkout, :boolean, :default => true
    add_column :deployment_plans, :run_post_checkout, :boolean, :default => true
  end
end
