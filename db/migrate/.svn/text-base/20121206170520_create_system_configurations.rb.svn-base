class CreateSystemConfigurations < ActiveRecord::Migration
  def change
    create_table :system_configurations do |t|
      t.string :name
      t.boolean :in_effect
      t.boolean :deployments_future_schedulable
      t.boolean :switches_future_schedulable

      t.timestamps
    end
  end
end
