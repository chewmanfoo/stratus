class AddAcceptedByToReloadRequests < ActiveRecord::Migration
  def change
    add_column :reload_requests, :accepted_by, :string
  end
end
