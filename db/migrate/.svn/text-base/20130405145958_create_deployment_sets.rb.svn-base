class CreateDeploymentSets < ActiveRecord::Migration
  def change
    create_table :deployment_sets do |t|
      t.integer :application_id
      t.string :build_number
      t.boolean :run_pre_checkout
      t.boolean :run_post_checkout
      t.text :changelist
      t.boolean :auto_accept
      t.boolean :auto_start
      t.integer :created_by

      t.timestamps
    end
  end
end
