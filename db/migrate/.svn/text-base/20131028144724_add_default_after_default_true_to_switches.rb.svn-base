class AddDefaultAfterDefaultTrueToSwitches < ActiveRecord::Migration
  def up
    change_column :switches, :default_after, :boolean, :default => true
  end

  def down
    change_column :switches, :default_after, :boolean, :default => nil
  end
end
