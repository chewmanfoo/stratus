class DropPackageFromDeployments < ActiveRecord::Migration
  def up
    remove_column :deployments, :package
  end

  def down
    add_column :deployments, :package, :string
  end
end
