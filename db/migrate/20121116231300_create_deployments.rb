class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.boolean :latest
      t.integer :build_number
      t.integer :environment_id
      t.string :package
      t.integer :role_id
      t.string :to_release_at
      t.text :email_notification_list
      t.string :accepted_by
      t.string :completed_by
      t.string :rejected_by
      t.datetime :accepted_at
      t.datetime :completed_at
      t.datetime :rejected_at

      t.timestamps
    end
  end
end
