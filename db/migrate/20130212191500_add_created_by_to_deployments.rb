class AddCreatedByToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :created_by, :integer
  end
end
