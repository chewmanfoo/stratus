class CreateDeployableEnvironmentLists < ActiveRecord::Migration
  def change
    create_table :deployable_environment_lists do |t|
      t.integer :environment_id
      t.integer :system_configuration_id

      t.timestamps
    end
  end
end
