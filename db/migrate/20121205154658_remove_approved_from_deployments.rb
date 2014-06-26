class RemoveApprovedFromDeployments < ActiveRecord::Migration
  def up
    remove_column :deployments, :approved
  end

  def down
    add_column :deployments, :approved, :boolean
  end
end
