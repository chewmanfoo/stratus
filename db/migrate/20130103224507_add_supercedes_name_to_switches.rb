class AddSupercedesNameToSwitches < ActiveRecord::Migration
  def change
    add_column :switches, :supercedes_name, :string
  end
end
