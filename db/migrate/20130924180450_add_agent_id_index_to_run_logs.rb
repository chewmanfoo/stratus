class AddAgentIdIndexToRunLogs < ActiveRecord::Migration
  def change
    add_index :run_logs, :agent_id
  end
end
