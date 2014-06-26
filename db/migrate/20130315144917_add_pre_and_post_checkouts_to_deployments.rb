class AddPreAndPostCheckoutsToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :pre_checkout, :text
    add_column :deployments, :post_checkout, :text
  end
end
