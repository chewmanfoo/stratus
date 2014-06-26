class CreateDeploymentSetEnvironmentLists < ActiveRecord::Migration
  def change
    create_table :deployment_set_environment_lists do |t|
      t.integer :deployment_set_id
      t.integer :environment_id

      t.timestamps
    end
  end
end
