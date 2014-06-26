class AddTcsEnvironmentToEnvironments < ActiveRecord::Migration
  def change
    add_column :environments, :tcs_environment, :boolean
  end
end
