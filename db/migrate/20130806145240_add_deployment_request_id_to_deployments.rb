class AddDeploymentRequestIdToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :deployment_request_id, :integer
  end
end
