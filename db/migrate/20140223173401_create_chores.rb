class CreateChores < ActiveRecord::Migration
  def change
    unless table_exists?(:chores)
      create_table :chores do |t|
        t.string :name
        t.string :command
        t.string :success
        t.string :fail

        t.timestamps
      end
    end
  end
end
