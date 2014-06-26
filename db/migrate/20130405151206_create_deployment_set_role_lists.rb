class CreateDeploymentSetRoleLists < ActiveRecord::Migration
  def change
    create_table :deployment_set_role_lists do |t|
      t.integer :deployment_set_id
      t.integer :role_id

      t.timestamps
    end
  end
end
