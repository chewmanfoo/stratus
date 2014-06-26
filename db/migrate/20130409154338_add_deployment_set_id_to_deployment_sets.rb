class AddDeploymentSetIdToDeploymentSets < ActiveRecord::Migration
  def change
    add_column :deployment_sets, :deployment_set_id, :integer
  end
end
