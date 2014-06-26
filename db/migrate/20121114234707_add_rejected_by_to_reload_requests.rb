class AddRejectedByToReloadRequests < ActiveRecord::Migration
  def change
    add_column :reload_requests, :rejected_by, :string
  end
end
