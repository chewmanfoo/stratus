class AddCheckoutBooleansToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :run_pre_checkout, :boolean
    add_column :deployments, :run_post_checkout, :boolean
  end
end
