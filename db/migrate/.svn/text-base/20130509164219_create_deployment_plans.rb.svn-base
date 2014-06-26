class CreateDeploymentPlans < ActiveRecord::Migration
  def change
    create_table :deployment_plans do |t|
      t.string :name
      t.references :application
      t.references :mail_recipient

      t.timestamps
    end
    add_index :deployment_plans, :application_id
    add_index :deployment_plans, :mail_recipient_id
  end
end
