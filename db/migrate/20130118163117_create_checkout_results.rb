class CreateCheckoutResults < ActiveRecord::Migration
  def change
    create_table :checkout_results do |t|
      t.string :name
      t.datetime :last_run_at
      t.integer :server_id

      t.timestamps
    end
  end
end
