class ChangeByToForeignKeysToUsers < ActiveRecord::Migration
  def up
    change_column :switches, :accepted_by, :integer
    change_column :switches, :completed_by, :integer
    change_column :switches, :rejected_by, :integer
  end

  def down
    change_column :switches, :accepted_by, :string
    change_column :switches, :completed_by, :string
    change_column :switches, :rejected_by, :string
  end
end
