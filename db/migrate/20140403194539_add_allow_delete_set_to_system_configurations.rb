class AddAllowDeleteSetToSystemConfigurations < ActiveRecord::Migration
  def change
    add_column :system_configurations, :allow_delete_set, :text
  end
end
