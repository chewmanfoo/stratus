class CreateReloadRequests < ActiveRecord::Migration
  def change
    create_table :reload_requests do |t|
      t.boolean :latest
      t.integer :build_number
      t.integer :environment_id
      t.string :package
      t.integer :role_id
      t.string :to_release_at
      t.text :email_notification_list

      t.timestamps
    end
  end
end
