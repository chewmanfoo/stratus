class AddNewFieldsToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :batch_group_id, :integer
    add_column :deployments, :reason, :string
  end
end
