class AddIndexsToReloadRequests < ActiveRecord::Migration
  def change
    add_index :reload_requests, :role_id
    add_index :reload_requests, :environment_id
  end
end
