class AddDebugModeToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :debug_mode, :boolean
  end
end
