class AddVerifySwitchesToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :verify_switches, :boolean
  end
end
