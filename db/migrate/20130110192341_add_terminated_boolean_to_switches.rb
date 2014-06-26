class AddTerminatedBooleanToSwitches < ActiveRecord::Migration
  def change
    add_column :switches, :terminated, :boolean, :default => false
  end
end
