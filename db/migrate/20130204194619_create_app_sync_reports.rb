class CreateAppSyncReports < ActiveRecord::Migration
  def change
    create_table :app_sync_reports do |t|
      t.string :name
      t.integer :creator_id
      t.string :subtitle
      t.integer :standard_environment_id
      t.integer :target_environment_id
      t.text :header
      t.text :body
      t.text :footer

      t.timestamps
    end
  end
end
