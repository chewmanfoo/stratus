class Deployment < ActiveRecord::Base
  include Workflow

  attr_accessible :accepted_at, :accepted_by, :build_number, 
                  :completed_at, :completed_by, :mail_recipient_id, 
                  :created_by, :environment_id, :latest,  
                  :rejected_at, :rejected_by, :role_id, 
                  :to_release_at, :rejection_reason, :changelist,
                  :terminated_at, :terminated_by,
                  :application_id, :application_tokens, :disc_space,
                  :run_pre_checkout, :run_post_checkout, :workflow_state,
                  :skip_diskspace_check, :auto_accept, :auto_start,
                  :auto_promote, :deployment_set_id, :deployment_request_id,
                  :batch, :batch_group_id, :reason

  attr_reader :application_tokens
  attr_accessor :servers

  belongs_to :role
  belongs_to :environment
  belongs_to :mail_recipient
  belongs_to :application
  belongs_to :deployment_set
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  belongs_to :acceptor, :class_name => "User", :foreign_key => :accepted_by
  belongs_to :rejector, :class_name => "User", :foreign_key => :rejected_by
  belongs_to :terminator, :class_name => "User", :foreign_key => :terminated_by
  belongs_to :starter, :class_name => "User", :foreign_key => :started_by
  belongs_to :completor, :class_name => "User", :foreign_key => :completed_by
  belongs_to :approver, :class_name => "User", :foreign_key => :approved_by
  belongs_to :rejector, :class_name => "User", :foreign_key => :rejected_by
  belongs_to :deployment_set
  belongs_to :deployment_request
  belongs_to :batch_group
 
  has_many :deployment_run_logs, :foreign_key => "agent_id", :dependent => :destroy
  has_many :deployment_timings, :dependent => :destroy
  has_many :retrys, :dependent => :destroy

  delegate :name, :to => :role, :prefix => true, :allow_nil => true
  delegate :name, :to => :environment, :prefix => true, :allow_nil => true
  delegate :name, :to => :application, :prefix => true, :allow_nil => true
  delegate :name, :to => :mail_recipient, :prefix => true, :allow_nil => true
  delegate :name, :to => :batch_group, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :approver, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :starter, :prefix => true, :allow_nil => true
  delegate :svn_login, :to => :starter, :prefix => true, :allow_nil => true
  delegate :svn_password, :to => :starter, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :rejector, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :terminator, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :completor, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :acceptor, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :creator, :prefix => true, :allow_nil => true
  delegate :email, :to => :creator, :prefix => true, :allow_nil => true
  delegate :email, :to => :approver, :prefix => true, :allow_nil => true
  delegate :email, :to => :acceptor, :prefix => true, :allow_nil => true
  delegate :email, :to => :rejector, :prefix => true, :allow_nil => true
  delegate :email, :to => :terminator, :prefix => true, :allow_nil => true
  delegate :email, :to => :starter, :prefix => true, :allow_nil => true
  delegate :email, :to => :completor, :prefix => true, :allow_nil => true
  delegate :appropriate_roles, :to => :application, :prefix => false, :allow_nil => true 
  delegate :deployment_plan, :to => :application, :prefix => true, :allow_nil => true
  delegate :check_reo_for_approval?, :to => :application, :prefix => true, :allow_nil => true

  validates :application_id, :presence => true
  validates :role_id, :presence => true
  validates :environment_id, :presence => true
  validate :must_be_deployable_environment
  validate :must_be_appropriate_role
  validates :build_number, :presence => true, :unless => :latest?
  validates :build_number, :format => { :with => /\d+\-\d+/, :message => "must contain build#-version.  Typically this is something-1." }
  validates :mail_recipient_id, :presence => true
  validates :reason, :presence => { :if => :env_change_requires_reason? }
# need more reason validators for format and :chg_record_exists in ServiceNow  

  alias_attribute :version, :build_number

  alias_attribute :run_logs, :deployment_run_logs

  alias_attribute :name, :full_name

#**********************************************************************************
# Workflow 
#**********************************************************************************
  workflow do
    state :new do
      event :accept, :transitions_to => :awaiting_approval
      event :approve, :transitions_to => :awaiting_acceptance
      event :terminate, :transitions_to => :fail_review
    end
    state :awaiting_acceptance do
      event :accept, :transitions_to => :approved
      event :terminate, :transitions_to => :fail_review
    end
    state :awaiting_approval do
      event :approve, :transitions_to => :approved
      event :start, :transitions_to => :started
      event :terminate, :transitions_to => :fail_review

      on_entry do
        config = SystemConfiguration.in_effect
        unless approval_needed?
          debug("DEBUG::in awaiting_approval but approval not needed, transitioning to :approved")
          approve!
        else
          unless creator.blank?
            # if the deployment was created by an approver, no need to stop
            if creator.approves?
              e = DeploymentWorkflowEngine.new(id, config.id)
              e.approve(creator)
              debug("DEBUG::in awaiting_approval, creater is approver, transitioning to :approved") if config.debug_mode?
            else
              if config.check_reo_for_deployments_approval?
                # check REO for approval here
                debug("DEBUG::in awaiting_approval, creator is not approver, stopping in :awaiting_approval") 
                debug("DEBUG::in awaiting_approval, check with REO for approval") 
                CheckReoForApprovalDeploymentWorker.perform_async(id)
              end
            end
          end
        end
      end
    end
    state :approved do
      event :start, :transitions_to => :started
      event :terminate, :transitions_to => :fail_review

      on_entry do
        config = SystemConfiguration.in_effect
        if auto_start?
          unless creator.setup_incomplete?
            e = DeploymentWorkflowEngine.new(id, config.id)
            e.start(creator)
            debug("DEBUG::in approved, condition auto_start, transitioning to :started")
          end
        end
      end
    end
    state :started do
      event :execute, :transitions_to => :check_concurrent_deployment
      event :terminate, :transitions_to => :fail_review
 
      on_entry do
# removed 9/17 - don't think we need this any more
#        CheckApprovalDeploymentWorker.perform_async(id) if approval_needed?
        CheckoutDeploymentWorker.perform_async(id) if run_pre_checkout?
        execute!
      end
    end
    state :check_concurrent_deployment do
      event :proceed_check_cobbler, :transitions_to => :check_cobbler
      event :terminate, :transitions_to => :fail_review

      on_entry do
        CheckConcurrentDeploymentWorker.perform_async(id) if Deployment.inflight.concurrent(application_id,role_id,environment_id).size > 0
      end
    end
    state :check_cobbler do
      event :proceed_check_disc_space, :transitions_to => :check_disc_space
      event :terminate, :transitions_to => :fail_review
      
      on_entry do
        CheckCobblerDeploymentWorker.perform_async(id)
      end
    end
    state :check_disc_space do
      event :proceed_capture_rollback_version, :transitions_to => :capture_rollback_version
      event :terminate, :transitions_to => :fail_review
      
      on_entry do
        if skip_diskspace_check?
          log_result("CheckDiscSpaceWorker::perform -> skipping because skip_diskspace_check is true")
          log_result("CheckDiscSpaceWorker::perform -> end")
          proceed_capture_rollback_version!
        else
          CheckDiscSpaceWorker.perform_async(id)
        end
      end
    end
    state :capture_rollback_version do
      event :proceed_subversion_file, :transitions_to => :subversion_file
      event :terminate, :transitions_to => :fail_review

      on_entry do
        CheckBuildOnServerWorker.perform_async(id)
      end
    end
    state :subversion_file do
      event :proceed_syncmanifest, :transitions_to => :syncmanifest
      event :terminate, :transitions_to => :fail_review

      on_entry do
        SvnFileDeploymentWorker.perform_async(id)
      end
    end
    state :syncmanifest do
      event :proceed_go_oos, :transitions_to => :go_oos
      event :terminate, :transitions_to => :fail_review

      on_entry do
        SyncmanifestDeploymentWorker.perform_async(id)
      end
    end
    state :go_oos do
      event :proceed_check_oos, :transitions_to => :check_oos
      event :proceed_deploy, :transitions_to => :deploy
      event :terminate, :transitions_to => :fail_review
      
      on_entry do
# verify that SystemConfiguration.in_effect.go_oos(id) is true
# this verifies global SystemConfiguration.use_oos_for_deployments?
# and this.application.use_oos_for_deployments? is true.
        if (SystemConfiguration.in_effect.use_oos_for_deployments? && application.use_oos_for_deployments? && application.oos_environment?(environment))
          OosDeploymentWorker.perform_async(id)
        else
          log_result("Skipping OOS because System Configuration has use_oos_for_deployments set to [#{SystemConfiguration.in_effect.use_oos_for_deployments?}] or Application #{application_name} has use_oos_for_deployments set to [#{application.use_oos_for_deployments?}]")
          proceed_deploy!
        end      
      end
    end
    state :check_oos do
      event :proceed_bleedoff, :transitions_to => :bleedoff
      event :terminate, :transitions_to => :fail_review

      on_entry do
        if (SystemConfiguration.in_effect.use_oos_for_deployments? && application.use_oos_for_deployments? && application.oos_environment?(environment))
          CheckOosDeploymentWorker.perform_async(id)
        else
          log_result("Skipping OOS because System Configuration has use_oos_for_deployments set to [#{SystemConfiguration.in_effect.use_oos_for_deployments?}] or Application #{application_name} has use_oos_for_deployments set to [#{application.use_oos_for_deployments?}]")
          proceed_bleedoff!
        end      
      end
    end
    state :bleedoff do
      event :proceed_deploy, :transitions_to => :deploy
      event :terminate, :transitions_to => :fail_review

      on_entry do
        if (SystemConfiguration.in_effect.use_oos_for_deployments? && application.use_oos_for_deployments? && application.oos_environment?(environment))
          BleedoffDeploymentWorker.perform_async(id)
        else
          log_result("Skipping bleed off because System Configuration has use_oos_for_deployments set to [#{SystemConfiguration.in_effect.use_oos_for_deployments?}] or Application #{application_name} has use_oos_for_deployments set to [#{application.use_oos_for_deployments?}]")
          proceed_deploy!
        end      
      end
    end
    state :deploy do
      event :proceed_check_deployment, :transitions_to => :check_deployment
      event :complete_review, :transitions_to => :complete_review
      event :proceed_go_is, :transitions_to => :go_is
      event :terminate, :transitions_to => :fail_review
      
      on_entry do
        DeployDeploymentWorker.perform_async(id)
      end
    end
    state :check_deployment do
      event :proceed_redeploy, :transitions_to => :redeploy
      event :proceed_go_is, :transitions_to => :go_is
      event :complete, :transitions_to => :execution_complete
      event :complete_review, :transitions_to => :complete_review
      event :terminate, :transitions_to => :fail_review
      event :fail_review, :transitions_to => :fail_review

      on_entry do
        CheckDeploymentWorker.perform_async(id)
        CheckoutDeploymentWorker.perform_async(id) if run_post_checkout?
      end
    end
    state :redeploy do
      event :proceed_check_deployment, :transitions_to => :check_deployment
      event :proceed_go_is, :transitions_to => :go_is
      event :complete_review, :transitions_to => :complete_review
      event :terminate, :transitions_to => :fail_review

      on_entry do
        DeployDeploymentWorker.perform_async(id)
      end
    end
    state :go_is do
      event :proceed_check_is, :transitions_to => :check_is
      event :complete_review, :transitions_to => :complete_review
      event :terminate, :transitions_to => :fail_review

      on_entry do
        if (SystemConfiguration.in_effect.use_oos_for_deployments? && application.use_oos_for_deployments? && application.oos_environment?(environment))
          IsDeploymentWorker.perform_async(id)
        else
          log_result("Skipping OOS because System Configuration has use_oos_for_deployments set to [#{SystemConfiguration.in_effect.use_oos_for_deployments?}] or Application #{application_name} has use_oos_for_deployments set to [#{application.use_oos_for_deployments?}]")
          complete_review!
        end      
      end

    end
    state :check_is do
      event :complete_review, :transitions_to => :complete_review
      event :terminate, :transitions_to => :fail_review

      on_entry do
        if (SystemConfiguration.in_effect.use_oos_for_deployments? && application.use_oos_for_deployments? && application.oos_environment?(environment))
          CheckIsDeploymentWorker.perform_async(id)
        else
          log_result("Skipping OOS because System Configuration has use_oos_for_deployments set to [#{SystemConfiguration.in_effect.use_oos_for_deployments?}] or Application #{application_name} has use_oos_for_deployments set to [#{application.use_oos_for_deployments?}]")
          complete_review!
        end      
      end

    end
    state :complete_review do
      event :complete, :transitions_to => :complete
      event :complete_review, :transitions_to => :complete_review
 
      on_entry do
        config = SystemConfiguration.in_effect
        if config.allow_auto_promotion?
          @new = creator.created_deployments.create(:application_id => id,
                                    :build_number => build_number,
                                    :run_pre_checkout => run_pre_checkout,
                                    :run_post_checkout => run_post_checkout,
                                    :auto_accept => true,
                                    :auto_start => true,
                                    :mail_recipient_id => mail_recipient_id,
                                    :environment_id => environment_id,
                                    :role_id => role_id)
          if @new.save
            s = DeploymentWorkflowEngine.new(@new.id, config.id)
            if s.create(creator)
              logger.info("Deployment #{@new.name} created. in workflow engine")
            end
          end
        end
      end
    end
    state :fail_review do
      event :complete, :transitions_to => :complete

      on_entry do
        in_retry = false
        terminated = true
      end
    end
    state :execution_complete do
      event :complete, :transitions_to => :complete

      on_entry do
        in_retry = false
      end
    end
    state :complete 

    on_transition do |from, to, triggering_event, *event_args|
      add_timing(from, "ended")
      add_timing(to, "started") 
      debug("DEBUG::transitioning from #{from} to #{to} because of #{triggering_event}")
    end
  end

  def add_timing(state, event)
    deployment_timings.where(:state => state, :event => event).delete_all
    d = deployment_timings.create(:state => state, :event => event)
logger.info "created deployment_timing #{d.name}"
  end

#**********************************************************************************
# Scopes 
#**********************************************************************************

  scope :incomplete_or_rejected, :conditions => ["completed_at is NULL OR rejected_at is NOT NULL"]
  scope :incomplete, :conditions => ["completed_at is NULL"]
  scope :inflight, :conditions => ["workflow_state NOT IN ('complete_review','fail_review','execution_complete','complete')"]
  scope :landed, :conditions => ["workflow_state IN ('complete_review','fail_review')"]
  scope :past_landed, :conditions => ["workflow_state IN ('complete_review','fail_review','execution_complete','complete')"]
  scope :concurrent, lambda{ |a,r,e| where(application_id: a, role_id: r, environment_id: e) }
  scope :created_by_id, lambda{ |i| where(created_by: i) } 
  scope :started_by_id, lambda{ |i| where(started_by: i) } 
  scope :accepted_by_id, lambda{ |i| where(accepted_by: i) } 
  scope :by_user, lambda{ |i| created_by_id(i) || started_by_id(i) } 
  scope :by_acceptor, lambda{ |i| accepted_by_id(i) }
  scope :by_server_id, lambda{ |i| select(:id => i) }

  def self.search(search)
    if search
      find(:all, :conditions => ['build_number LIKE ?', "%#{search}%"]) + joins(:application).where('applications.name LIKE ?', "%#{search}%")
    else
      find(:all)
    end
  end

  def total_time_seconds
    s = current_state.to_s
    t = DeploymentTiming.by_deployment_id_by_state(id, s)
    unless t.blank?
      t.last.created_at - created_at 
    end
  end

  def bleedoff_seconds
    application_deployment_plan.bleedoff_seconds || 0
  end

  def accept
  end

  def reject(reason="inappropriate")
    rejection_reason = reason
  end

  def approve()
  end
  
  def start()
  end

  def complete()
  end

  def build_number=(bn)
    write_attribute(:build_number, bn.try(:strip))
  end

  def package
    "#{application_name}-#{build_number}"
  end

  def dsl_package
    "#{package.gsub(/(.*)[.-]\d+-\d+$/,'\1')}"
  end

  def reo_package
    dsl_package
  end

  def reo_version
    build_number.split('.')[-1]
  end 

  def destroyable?
    ! (current_state >= :started)
  end

  def editable?
    ! (current_state >= :started)
  end

  def cancelable?
    new? || awaiting_approval? || approved?
  end

  def pre_approved?
    ApprovedBuild.by_application_name_by_build_number(application_name, build_number).size > 0 || approved?
  end

  def approved 
    if (approved_at)
      approved_at <= Time.now
    else
      unless current_state >= :approved 
        false
      else
        true
      end
    end
  end

  def approvable?
    ! approved && ! rejected && ! complete_review? && ! fail_review? && ! complete? && ! execution_complete?
  end

  def auto_approved_env?
    SystemConfiguration.in_effect.auto_approved_environments.include?(environment)
  end

  def app_uses_approval?
    application_check_reo_for_approval?
  end

  def approval_needed?
# instead, consult SystemConfiguration.in_effect
    !(auto_approved_env?) && app_uses_approval? && approvable?
  end

  def approved=(value)
    if value == "1"
      self.approved_at = Time.now 
      release!
    else
      self.approved_at = nil
    end
  end

  def completed
    if (self.completed_at)
      completed_at <= Time.now
    else
      false
    end
  end

  def completable?
    ! completed && started && complete_review?
  end

  def rollbackable?
    ! rollback_build_number.blank? && completable?
  end

  def failable?
#    fail_review? || ! completed && started
    fail_review? 
  end

  def accepted
    if (accepted_at)
      accepted_at <= Time.now
    else
      false
    end
  end

  def acceptable?
    ! accepted && ! rejected && current_state < :started
  end

  def rejected
    if (rejected_at)
      rejected_at <= Time.now
    else
      false
    end
  end
  
  def rejectable?
    ! rejected && ! accepted && current_state < :started
  end

  def started
    if (started_at)
      started_at <= Time.now
    else
      false
    end
  end

  def startable?
    if approval_needed? 
      accepted && approved && ! started && ! complete_review? && ! fail_review? && ! complete? && ! execution_complete?
    else
      accepted && ! started && ! complete_review? && ! fail_review? && ! complete? && ! execution_complete?
    end
  end

  def terminated
    if (terminated_at)
      terminated_at <= Time.now
    else
      false
    end
  end

  def terminatable?
    current_state >= :started && current_state < :complete_review 
  end

  def clonable?
    current_state < :started
  end

  def instance_terminated(id)
    if Deployment.exist?(id)
      @d = Deployment.find(id) 
      @d.terminated?
    end
  end

#  def latest=(value)
#    unless value == "0"
#      self.build_number = ''
# get latest build from this application_name for this environment_name
#      @environment_name = self.environment_name
#      @application_name = self.application_name
#      @relarr = Array.new
#      @relst = `wget -q -O - "$@" #{DSL_RPM_CACHE_URL}|grep #{@application_name}`
#      @relarr = @relst.split("\n").map {|v| v.split(' ')[0].gsub('.noarch.rpm','')}
#      @prever = `wget -q -O - "$@" #{self.svn_file}|grep #{@application_name}`
#      self.latest = value
#      self.build_number = 'latest'
#    end
#  end

  def application_tokens=(ids)
    self.application_id = ids.split(",").first
  end

  def servers
    Server.active_by_environment_and_role_and_runtime_env(environment_id, role_id, "certification")
#    @servers||Server.active_by_environment_and_role_and_runtime_env(environment_id, role_id, "production")
  end

  def servers=(_s)
    @servers = _s
  end

  def self.PROCESS_OWNER
    "DeveloperServices@sabre.com"
  end
 
  def full_name
    "#{application_name} ##{build_number || '<latest>'} for #{environment_name}/#{role_name}"
  end

  def partial_name
    "#{application_name} ##{build_number || '<latest>'}"
  end

  def target_name
    "for #{environment_name}/#{role_name}"
  end

  def log_result(log)
    @l = DeploymentRunLog.create(:log => log)
    run_logs << @l
  end

  def self.log_result(deployment, log)
    @l = DeploymentRunLog.create(:log => log)
    deployment.run_logs << @l
  end

  def svn_file
    "applications.csv"
  end

  def svn_path
    "http://#{SVN_SERVER}/#{PUPPET_PATH}/#{environment_name}/conf"    
#    "http://tcysvn01.dev.sabre.com/tvly/build-tools/trunk/stratus/junk/conf"
  end

protected
  def must_be_deployable_environment
    if !(SystemConfiguration.in_effect.deployable_environments.include?(environment))
      errors.add(:environment, "must be deployable")
    end
  end

  def must_be_appropriate_role
    unless appropriate_roles.include?(role)
      errors.add(:role, "must be appropriate for this application")
    end
  end

  def env_change_requires_reason?
    environment.requires_reason?
  end
  
  def debug(msg)
    config = SystemConfiguration.in_effect
    log_result(msg) if config.debug_mode?
  end
end
