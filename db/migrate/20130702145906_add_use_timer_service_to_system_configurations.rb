class AddUseTimerServiceToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :use_timer_service, :boolean
  end
end
