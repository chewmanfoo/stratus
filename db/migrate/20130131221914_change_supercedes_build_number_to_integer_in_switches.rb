class ChangeSupercedesBuildNumberToIntegerInSwitches < ActiveRecord::Migration
  def up
    change_column :switches, :supercedes_build_number, :integer
  end

  def down
    change_column :switches, :supercedes_build_number, :string
  end
end
