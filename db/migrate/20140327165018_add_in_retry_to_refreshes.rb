class AddInRetryToRefreshes < ActiveRecord::Migration
  def change
    add_column :refreshes, :in_retry, :boolean
  end
end
