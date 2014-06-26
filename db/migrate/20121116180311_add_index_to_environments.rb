class AddIndexToEnvironments < ActiveRecord::Migration
  def change
    add_index :environments, :next_environment_id
  end
end
