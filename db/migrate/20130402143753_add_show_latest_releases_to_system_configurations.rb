class AddShowLatestReleasesToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :show_latest_releases, :boolean
  end
end
