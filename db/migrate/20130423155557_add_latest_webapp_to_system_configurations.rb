class AddLatestWebappToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :latest_webapp, :text
  end
end
