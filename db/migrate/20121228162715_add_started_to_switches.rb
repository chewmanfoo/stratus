class AddStartedToSwitches < ActiveRecord::Migration
  def change
    add_column :switches, :started_by, :integer
    add_column :switches, :started_at, :datetime
  end
end
