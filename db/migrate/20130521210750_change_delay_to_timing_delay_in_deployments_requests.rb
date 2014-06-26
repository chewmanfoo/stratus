class ChangeDelayToTimingDelayInDeploymentsRequests < ActiveRecord::Migration
  def up
    rename_column :deployment_requests, :delay, :timing_delay
  end

  def down
  end
end
