class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.integer :role_id
      t.string :runtime_env
      t.integer :environment_id
      t.string :classes
      t.text :switches
      t.string :sub_runtime_env
      t.string :batch_group

      t.timestamps
    end
  end
end
