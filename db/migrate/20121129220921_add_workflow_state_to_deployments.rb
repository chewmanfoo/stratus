class AddWorkflowStateToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :workflow_state, :string
  end
end
