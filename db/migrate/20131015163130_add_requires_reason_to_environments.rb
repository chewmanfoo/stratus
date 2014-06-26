class AddRequiresReasonToEnvironments < ActiveRecord::Migration
  def change
    add_column :environments, :requires_reason, :boolean
  end
end
