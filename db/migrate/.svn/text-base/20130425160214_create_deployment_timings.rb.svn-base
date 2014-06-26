class CreateDeploymentTimings < ActiveRecord::Migration
  def change
    create_table :deployment_timings do |t|
      t.integer :deployment_id
      t.string :state
      t.string :event

      t.timestamps
    end
  end
end
