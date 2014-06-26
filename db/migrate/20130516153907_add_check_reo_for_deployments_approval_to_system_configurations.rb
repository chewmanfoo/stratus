class AddCheckReoForDeploymentsApprovalToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :check_reo_for_deployments_approval, :boolean
  end
end
