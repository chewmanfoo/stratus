class AddAcceptedCompletedRejectedToReloadRequests < ActiveRecord::Migration
  def change
    add_column :reload_requests, :accepted_at, :datetime
    add_column :reload_requests, :completed_at, :datetime
    add_column :reload_requests, :rejected_at, :datetime
  end
end
