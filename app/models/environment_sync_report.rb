class EnvironmentSyncReport < ActiveRecord::Base
  include Workflow

  attr_accessible :target_environment_id, :trusted_environment_id, :work_to_perform_id, :workflow_state,
                  :started_at, :started_by

  belongs_to :target_environment, :class_name => "Environment", :foreign_key => :target_environment_id
  belongs_to :trusted_environment, :class_name => "Environment", :foreign_key => :trusted_environment_id
  belongs_to :work_to_perform, :class_name => "EsrWork", :foreign_key => :work_to_perform_id
  belongs_to :starter, :class_name => "User", :foreign_key => :started_by
  has_many :esr_package_problems, :dependent => :destroy
  has_many :environment_sync_report_run_logs, :foreign_key => "agent_id", :dependent => :destroy

  delegate :name, :to => :target_environment, :prefix => true, :allow_nil => true
  delegate :name, :to => :trusted_environment, :prefix => true, :allow_nil => true
  delegate :name, :to => :work_to_perform, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :starter, :prefix => true, :allow_nil => true

  alias_attribute :run_logs, :environment_sync_report_run_logs

#**********************************************************************************
# Scopes
#**********************************************************************************

#**********************************************************************************
# Workflow
#**********************************************************************************
  workflow do
    state :new do
      event :start, :transitions_to => :capture_artifacts
    end
    state :capture_artifacts do
      event :proceed, :transitions_to => :do_comparisons
      event :reset, :transitions_to => :new
      
      on_entry do
        EnvironmentSyncReportWorker.perform_async(self.id)
      end 
    end
    state :do_comparisons do
      event :proceed, :transitions_to => :assemble_results
      event :reset, :transitions_to => :new
    end
    state :assemble_results do
      event :complete, :transitions_to => :complete
      event :reset, :transitions_to => :new
    end
    state :complete do
      event :reset, :transitions_to => :new

      on_entry do
logger.info "EnvironmentSyncReport ##{id} complete!"
      end
    end
  end

  def reset
    workflow_state = ""
    started_at = ""
    started_by = ""
  end

  def startable?
    self.new?
  end

  def rerunable?
    self.complete?
  end

  def problems_by_conflict(c) 
    esr_package_problems.where(conflict: c)
  end

  def name
    "ESR #{trusted_environment_name} to #{target_environment_name}" 
  end

  def self.log_result(esr,log)
    @l = EnvironmentSyncReportRunLog.create(:log => log)
    esr.run_logs << @l
  end
 
end
