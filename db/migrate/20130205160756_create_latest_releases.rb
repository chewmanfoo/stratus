class CreateLatestReleases < ActiveRecord::Migration
  def change
    create_table :latest_releases do |t|
      t.string :name

      t.timestamps
    end
  end
end
