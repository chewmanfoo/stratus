class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.string :name
      t.references :environment
      t.references :role
      t.references :application
      t.string :build_number
      t.boolean :latest
      t.text :reason
      t.references :first_flow_part

      t.timestamps
    end
    add_index :flows, :environment_id
    add_index :flows, :role_id
    add_index :flows, :application_id
    add_index :flows, :first_flow_part_id
  end
end
