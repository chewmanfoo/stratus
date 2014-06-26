class ChangeBuildNumberToStringOnDeployments < ActiveRecord::Migration
  def up
    change_column :deployments, :build_number, :string
  end

  def down
    change_column :deployments, :build_number, :integer
  end
end
