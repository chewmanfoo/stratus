class AddEnvironmentIdToSyncJobs < ActiveRecord::Migration
  def change
    add_column :sync_jobs, :environment_id, :integer
  end
end
