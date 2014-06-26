class AddWorkflowStateToSwitches < ActiveRecord::Migration
  def change
    add_column :switches, :workflow_state, :string
  end
end
