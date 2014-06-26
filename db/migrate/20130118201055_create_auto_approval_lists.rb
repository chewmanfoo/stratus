class CreateAutoApprovalLists < ActiveRecord::Migration
  def change
    create_table :auto_approval_lists do |t|
      t.integer :system_configuration_id
      t.integer :environment_id

      t.timestamps
    end
  end
end
