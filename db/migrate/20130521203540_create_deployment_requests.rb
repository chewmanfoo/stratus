class CreateDeploymentRequests < ActiveRecord::Migration
  def change
    create_table :deployment_requests do |t|
      t.string :package
      t.string :build
      t.string :environment
      t.string :auth_key
      t.integer :delay

      t.timestamps
    end
  end
end
