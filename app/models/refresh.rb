class Refresh < ActiveRecord::Base
include Workflow

  attr_accessible :environment_id, :role_id, :changelist, :created_by, :workflow_state, :in_retry, 
                  :completed_at, :terminated_at

  belongs_to :environment
  belongs_to :role
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by

  has_many :refresh_run_logs, :foreign_key => "agent_id", :dependent => :destroy

  delegate :name, :to => :role, :prefix => true, :allow_nil => true
  delegate :name, :to => :environment, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :creator, :prefix => true, :allow_nil => true 
  delegate :email, :to => :creator, :prefix => true, :allow_nil => true

  validates :role_id, :presence => true
  validates :environment_id, :presence => true

  alias_attribute :run_logs, :refresh_run_logs
  alias_attribute :partial_name, :full_name
  alias_attribute :name, :full_name
  alias_attribute :started_by, :created_by
  alias_attribute :started_at, :created_at

#**********************************************************************************
# Workflow
#**********************************************************************************

  workflow do
    state :new do
      event :start, :transitions_to => :syncmanifest
      event :terminate, :transitions_to => :fail
    end
    state :syncmanifest do
      event :proceed_deploy, :transitions_to => :deploy
      event :terminate, :transitions_to => :fail
      on_entry do
        SyncmanifestRefreshWorker.perform_async(id)
      end
    end
    state :deploy do
      event :proceed_complete, :transitions_to => :complete
      event :terminate, :transitions_to => :fail
      on_entry do
        DeployRefreshWorker.perform_async(id)
      end
    end
    state :complete do
      event :proceed_stop, :transitions_to => :finished
      on_entry do
        terminated = false
        in_retry = false
      end
    end
    state :fail do
      event :proceed_stop, :transitions_to => :finished
      on_entry do
        terminated = true
        in_retry = false
      end
    end
    state :finished
    on_transition do |from, to, triggering_event, *event_args|
      add_timing(from, "ended")
      add_timing(to, "started")
      debug("DEBUG::transitioning from #{from} to #{to} because of #{triggering_event}")
    end
  end

  def add_timing(state, event)
#    refresh_timings.where(:state => state, :event => event).delete_all
#    r = refresh_timings.create(:state => state, :event => event)
#logger.info "created refresh_timing #{r.name}"
logger.info "created refresh_timing"
  end

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :inflight, :conditions => ["workflow_state NOT IN ('complete','fail')"]
  scope :landed, :conditions => ["workflow_state IN ('complete','fail')"]
  scope :incomplete, :conditions => ["completed_at is NULL"]
  scope :created_by_id, lambda{ |i| where(created_by: i) }
  scope :by_user, lambda{ |i| created_by_id(i) }

  def servers
    Server.active_by_environment_and_role_and_runtime_env(environment_id, role_id, "certification")
#    @servers||Server.active_by_environment_and_role_and_runtime_env(environment_id, role_id, "production")
  end

  def completable?
    complete?
  end

  def failable?
    fail?
  end

  def terminatable?
    current_state < :complete
  end  

  def destroyable?
    true
  end

  def terminated
    if (terminated_at)
      terminated_at <= Time.now
    else
      false
    end
  end

  def servers
    Server.active_by_environment_and_role_and_runtime_env(environment_id, role_id, "certification")
#    @servers||Server.active_by_environment_and_role_and_runtime_env(environment_id, role_id, "production")
  end

  def full_name
    "Puppet refresh for #{environment_name}/#{role_name}"
  end

  def log_result(log)
    @l = RefreshRunLog.create(:log => log)
    run_logs << @l
  end

  def self.log_result(refresh, log)
    @l = RefreshRunLog.create(:log => log)
    refresh.run_logs << @l
  end

  def completed
    if (self.completed_at)
      completed_at <= Time.now
    else
      false
    end
  end

  def total_time_seconds
    s = current_state.to_s
#    t = RefreshTiming.by_refresh_id_by_state(id, s)
#    unless t.blank?
#      t.last.created_at - created_at
#    end
#  end
    "undef"
  end

  def target_name
    "for #{environment_name}/#{role_name}"
  end

protected
  def debug(msg)
    config = SystemConfiguration.in_effect
    log_result(msg) if config.debug_mode?
  end
end
