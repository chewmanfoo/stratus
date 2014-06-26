class AddInRetryToSyncJobs < ActiveRecord::Migration
  def change
    add_column :sync_jobs, :in_retry, :boolean
  end
end
