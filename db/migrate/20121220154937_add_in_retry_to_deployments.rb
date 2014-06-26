class AddInRetryToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :in_retry, :boolean
  end
end
