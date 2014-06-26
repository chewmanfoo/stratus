class AddTriggerRefreshCheckboxToAppSyncReports < ActiveRecord::Migration
  def change
    add_column :app_sync_reports, :trigger_refresh, :boolean
  end
end
