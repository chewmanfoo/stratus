class AddManagesBooleansToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :manages_users, :boolean
    add_column :groups, :manages_system, :boolean
    add_column :groups, :manages_database, :boolean
    add_column :groups, :manages_threads, :boolean
  end
end
