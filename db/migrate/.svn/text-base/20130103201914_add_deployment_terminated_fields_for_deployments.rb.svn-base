class AddDeploymentTerminatedFieldsForDeployments < ActiveRecord::Migration
  def up
    add_column :deployments, :terminated_at, :datetime
    add_column :deployments, :terminated_by, :integer
  end

  def down
  end
end
