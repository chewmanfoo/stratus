class AddTypeToSyncJobs < ActiveRecord::Migration
  def change
    add_column :sync_jobs, :type, :string
  end
end
