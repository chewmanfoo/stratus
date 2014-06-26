class AddSkipDiskspaceCheckToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :skip_diskspace_check, :boolean
  end
end
