class AddPuppetRefreshCronItemsToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :enable_puppet_refresh_cron, :boolean
    add_column :system_configurations, :puppet_refresh_batchsize, :integer
    add_column :system_configurations, :puppet_refresh_cron_timings, :string
  end
end
