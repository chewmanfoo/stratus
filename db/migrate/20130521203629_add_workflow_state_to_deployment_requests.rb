class AddWorkflowStateToDeploymentRequests < ActiveRecord::Migration
  def change
    add_column :deployment_requests, :workflow_state, :string
  end
end
