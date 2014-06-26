class CreateSyncJobs < ActiveRecord::Migration
  def change
    create_table :sync_jobs do |t|
      t.text :exceptions
      t.datetime :started_at
      t.integer :started_by
      t.datetime :completed_at
      t.string :workflow_state

      t.timestamps
    end
  end
end
