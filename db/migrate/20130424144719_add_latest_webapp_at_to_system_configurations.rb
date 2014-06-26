class AddLatestWebappAtToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :latest_webapp_at, :datetime
  end
end
