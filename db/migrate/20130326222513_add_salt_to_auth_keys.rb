class AddSaltToAuthKeys < ActiveRecord::Migration
  def change
    add_column :auth_keys, :salt, :string
  end
end
