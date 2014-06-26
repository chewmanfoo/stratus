class AddPackageToLatestReleases < ActiveRecord::Migration
  def change
    add_column :latest_releases, :package, :string
  end
end
