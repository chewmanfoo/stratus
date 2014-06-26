class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :admin
      t.boolean :active

      t.timestamps
    end
  end
end
