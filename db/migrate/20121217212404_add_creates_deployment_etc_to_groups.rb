class AddCreatesDeploymentEtcToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :creates_deployments, :boolean
    add_column :groups, :creates_switches, :boolean
    add_column :groups, :executes_deployments, :boolean
    add_column :groups, :executes_switches, :boolean
  end
end
