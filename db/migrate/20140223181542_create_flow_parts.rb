class CreateFlowParts < ActiveRecord::Migration
  def change
    create_table :flow_parts do |t|
      t.string :name
      t.references :chore
      t.references :next_flow_part

      t.timestamps
    end
    add_index :flow_parts, :chore_id
    add_index :flow_parts, :next_flow_part_id
  end
end
