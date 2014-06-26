class AddInRetryBooleanToSwitches < ActiveRecord::Migration
  def change
    add_column :switches, :in_retry, :boolean
  end
end
