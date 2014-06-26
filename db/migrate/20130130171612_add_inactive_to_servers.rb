class AddInactiveToServers < ActiveRecord::Migration
  def change
    add_column :servers, :inactive, :boolean
  end
end
