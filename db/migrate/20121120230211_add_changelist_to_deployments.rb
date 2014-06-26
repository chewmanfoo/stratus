class AddChangelistToDeployments < ActiveRecord::Migration
  def change
    add_column :deployments, :changelist, :text
  end
end
