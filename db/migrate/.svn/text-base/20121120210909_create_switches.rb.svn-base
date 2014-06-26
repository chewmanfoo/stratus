class CreateSwitches < ActiveRecord::Migration
  def change
    create_table :switches do |t|
      t.string :name
      t.boolean :latest
      t.integer :build_number
      t.integer :environment_id
      t.string :role_id
      t.string :accepted_by
      t.string :completed_by
      t.datetime :accepted_at
      t.datetime :completed_at
      t.datetime :rejected_at
      t.string :rejected_by

      t.timestamps
    end
  end
end
