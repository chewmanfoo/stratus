class CreateRetries < ActiveRecord::Migration
  def change
    create_table :retries do |t|
      t.string :workflow_state
      t.references :deployment

      t.timestamps
    end
    add_index :retries, :deployment_id
  end
end
