class AddRefreshesTripcaseToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :refreshes_tripcase, :boolean
  end
end
