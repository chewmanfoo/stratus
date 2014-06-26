class CreateAuthKeys < ActiveRecord::Migration
  def change
    create_table :auth_keys do |t|
      t.string :name
      t.string :key
      t.integer :created_by
      t.string :authorized_host_ip
      t.boolean :active
      t.string :seed

      t.timestamps
    end
  end
end
