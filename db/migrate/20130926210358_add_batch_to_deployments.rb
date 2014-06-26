class AddBatchToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :batch, :string
  end
end
