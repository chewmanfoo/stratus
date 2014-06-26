class CreateRefreshes < ActiveRecord::Migration
  def change
    create_table :refreshes do |t|
      t.string :workflow_state
      t.integer :created_by
      t.references :environment
      t.references :role
      t.text :changelist

      t.timestamps
    end
    add_index :refreshes, :environment_id
    add_index :refreshes, :role_id
  end
end
