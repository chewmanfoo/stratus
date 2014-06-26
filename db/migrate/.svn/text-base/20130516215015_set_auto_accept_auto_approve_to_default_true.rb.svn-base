class SetAutoAcceptAutoApproveToDefaultTrue < ActiveRecord::Migration
  def up
    change_column_default(:deployments, :auto_accept, true)
    change_column_default(:deployments, :auto_start, true)
  end

  def down
  end
end
