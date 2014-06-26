class ChangeDeploymentsByFieldsToUsersForeignKeys < ActiveRecord::Migration
  def up
    change_column :deployments, :accepted_by, :integer
    change_column :deployments, :completed_by, :integer
    change_column :deployments, :rejected_by, :integer
    change_column :deployments, :approved_by, :integer
    change_column :deployments, :started_by, :integer
  end

  def down
    change_column :deployments, :accepted_by, :string
    change_column :deployments, :completed_by, :string
    change_column :deployments, :rejected_by, :string
    change_column :deployments, :approved_by, :string
    change_column :deployments, :started_by, :string
  end
end
