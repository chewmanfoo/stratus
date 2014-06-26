class CreateEnvironmentSyncReports < ActiveRecord::Migration
  def change
    create_table :environment_sync_reports do |t|
      t.integer :trusted_environment_id
      t.integer :target_environment_id
      t.integer :work_to_perform_id
      t.string :workflow_state

      t.timestamps
    end
  end
end
