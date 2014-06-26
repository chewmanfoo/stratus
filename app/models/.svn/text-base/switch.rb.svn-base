class Switch < ActiveRecord::Base
  include Workflow

  attr_accessible :accepted_at, :accepted_by, :build_number, 
                  :completed_at, :completed_by, :environment_id, 
                  :latest, :name, :rejected_at, :rejected_by, 
                  :role_id, :mail_recipient_id, :switch_names,
                  :created_by, :in_retry, :deploy_to_first_server_only,
                  :workflow_state, :supercedes_name, :supercedes_build_number,
                  :default_after

  belongs_to :role
  belongs_to :environment
  belongs_to :mail_recipient
  belongs_to :creator, :class_name => "User", :foreign_key => :accepted_by
  belongs_to :acceptor, :class_name => "User", :foreign_key => :accepted_by
  belongs_to :rejector, :class_name => "User", :foreign_key => :rejected_by
  belongs_to :starter, :class_name => "User", :foreign_key => :started_by
  belongs_to :completor, :class_name => "User", :foreign_key => :completed_by
  has_many :switch_run_logs, :foreign_key => "agent_id", :dependent => :destroy

  delegate :name, :to => :role, :prefix => true, :allow_nil => true
  delegate :name, :to => :environment, :prefix => true, :allow_nil => true
  delegate :name, :to => :mail_recipient, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :creator, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :starter, :prefix => true, :allow_nil => true
  delegate :svn_login, :to => :starter, :prefix => true, :allow_nil => true
  delegate :svn_password, :to => :starter, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :rejector, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :completor, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :acceptor, :prefix => true, :allow_nil => true
  delegate :email, :to => :starter, :prefix => true, :allow_nil => true

  validates :name, :presence => true, :if => "switch_names.nil?"
  validates :mail_recipient_id, :presence => true, :if => "switch_names.nil?"
  validates :role_id, :presence => true
  validates :environment_id, :presence => true
  validates :build_number, :presence => true, :unless => :latest?
  validate :must_be_deployable_environment

  attr_accessor :switch_names
  
  alias_attribute :run_logs, :switch_run_logs

#**********************************************************************************
# Workflow
#**********************************************************************************
  workflow do
    state :new do
      event :accept, :transitions_to => :ready
    end
    state :ready do
      event :start, :transitions_to => :started
    end
    state :started do
      event :execute, :transitions_to => :check_cobbler
    end
    state :check_cobbler do
      event :proceed, :transitions_to => :subversion_file

      on_entry do
        CheckCobblerSwitchWorker.perform_async(self.id)
      end
    end
    state :subversion_file do
      event :proceed, :transitions_to => :syncmanifest

      on_entry do
        SvnFileSwitchWorker.perform_async(self.id)
      end
    end
    state :syncmanifest do
      event :proceed, :transitions_to => :deploy

      on_entry do
        SyncmanifestSwitchWorker.perform_async(self.id)
      end
    end
    state :deploy do
      event :proceed, :transitions_to => :check_deployment

      on_entry do
        DeploySwitchWorker.perform_async(self.id)
      end
    end
    state :check_deployment do
      event :complete, :transitions_to => :execution_complete
      event :complete_review, :transitions_to => :complete_review
      event :to_default_after, :transitions_to => :to_default_after 
      event :fail_review, :transitions_to => :fail_review

      on_entry do
        if (SystemConfiguration.in_effect.verify_switches?) 
          CheckSwitchWorker.perform_async(self.id)
        else
          self.class.log_result(self, "Skipping CheckSwitch because System Configuration has verify_switches set to [#{SystemConfiguration.in_effect.verify_switches?}]")
          if default_after?
            to_default_after!
          else
            complete_review!
          end
        end
      end
    end
    state :to_default_after do
      event :syncmanifest_again, :transitions_to => :syncmanifest_again

      on_entry do
        SvnFileDefaultSwitchWorker.perform_async(self.id)
      end
    end
    state :syncmanifest_again do
      event :complete_review, :transitions_to => :complete_review
      
      on_entry do
        SyncmanifestAgainSwitchWorker.perform_async(self.id)
      end
    end
    state :complete_review do
      event :complete, :transitions_to => :complete
    end
    state :fail_review do
      event :complete, :transitions_to => :complete
    end
    state :execution_complete do
      event :complete, :transitions_to => :complete
    end
    state :complete

    on_transition do |from, to, triggering_event, *event_args|
      self.class.log_result(self, "DEBUG::transitioning from #{from} to #{to} because of #{triggering_event}")
    end
  end

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :incomplete_or_rejected, :conditions => ["completed_at is NULL OR rejected_at is NOT NULL"]
  scope :incomplete, :conditions => ["completed_at is NULL"]
  scope :created_by_id, lambda{ |i| where(created_by: i) }
  scope :started_by_id, lambda{ |i| where(started_by: i) }
  scope :by_user, lambda{ |i| created_by_id(i) || started_by_id(i) }

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def supercedes_name=(sn)
    write_attribute(:supercedes_name, sn.try(:strip))
  end

  def name=(name)
    write_attribute(:name, name.try(:strip))
  end

  def servers
    Server.active_by_environment_and_role_and_runtime_env(environment_id, role_id, "certification")
  end

  def batch
  end

  def total_time_seconds
    ""
  end

  def first_server
    Server.by_environment_and_role_and_runtime_env(environment_id, role_id, "certification").sort_by(&:name).first
  end

  def server_name
    if deploy_to_first_server_only?
      first_server.name
    else
      nil
    end
  end

  def package
    "#{name}-#{build_number}"
  end

  def supercedes_package
    "#{supercedes_name}-#{supercedes_build_number}"
  end

  def destroyable?
    ! (self.current_state >= :started)
  end

  def editable?
    ! (self.current_state >= :started)
  end

  def cancelable?
    self.new? 
  end

  def completed
    if (self.completed_at)
      self.completed_at <= Time.now
    else
      false
    end
  end

  def completable?
    ! self.completed && self.started && self.complete_review?
  end

  def accepted
    if (self.accepted_at)
      self.accepted_at <= Time.now
    else
      false
    end
  end

  def acceptable?
    ! self.accepted && ! self.rejected
  end

  def rejected
    if (self.rejected_at)
      self.rejected_at <= Time.now
    else
      false
    end
  end

  def rejectable?
    ! self.rejected && ! self.accepted
  end

  def started
    if (self.started_at)
      self.started_at <= Time.now
    else
      false
    end
  end

  def startable?
     self.accepted && ! self.started
  end

  def self.PROCESS_OWNER
    "DeveloperServices@sabre.com"
  end

  def full_name
    "#{name} # #{build_number || '<latest>'} for #{environment_name}"
  end

  def partial_name
    "#{name} # #{build_number || '<latest>'}"
  end

  def target_name
    "for #{environment_name}"
  end

  def self.log_result(switch, log)
    @l = SwitchRunLog.create(:log => log)
    switch.run_logs << @l
  end

  def instance_terminated(id)
    if Switch.exist?(id)
      @s = Switch.find(id)
      @s.terminated?
    end
  end

  def svn_file
    "servers.csv"
  end

  def svn_path
    "http://#{SVN_SERVER}/#{PUPPET_PATH}/configuration/servers"
#    "http://tcysvn01.dev.sabre.com/tvly/build-tools/trunk/stratus/junk/conf"
  end

protected
  def must_be_deployable_environment
    if !(SystemConfiguration.in_effect.deployable_environments.include?(environment))
      errors.add(:environment, "must be deployable")
    end
  end
end
