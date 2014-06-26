class DeploymentRequest < ActiveRecord::Base
  include Workflow
  
  attr_accessible :auth_key, :build, :timing_delay, :environment, :package, :workflow_state, :application_id

  has_many :deployment_request_run_logs, :foreign_key => "agent_id", :dependent => :destroy
  has_one :deployment
  has_one :application

  validates :auth_key, :build, :environment, :package, :presence => true
  validate :verify_package
  validate :verify_deployment_plan
  validate :verify_environment
  validate :verify_auth_key

  delegate :id, :to => :deployment, :prefix => true, :allow_nil => true
  delegate :name, :to => :deployment, :prefix => true, :allow_nil => true
  delegate :workflow_state, :to => :deployment, :prefix => true, :allow_nil => true
  delegate :started_at, :to => :deployment, :prefix => true, :allow_nil => true
  delegate :completed_at, :to => :deployment, :prefix => true, :allow_nil => true
  delegate :in_retry, :to => :deployment, :prefix => true, :allow_nil => true

# timing_delay can be set to from 1 to 8 hours
# TODO add timing_delay inclusion set by SystemConfiguration
  validates :timing_delay, :numericality => true, :inclusion => { :in => 1..8 }, :allow_nil => true

  alias_attribute :run_logs, :deployment_request_run_logs
#**********************************************************************************
# Workflow
#**********************************************************************************
  workflow do
    state :new do
      event :verified, :transitions_to => :processing

      on_entry do
# verify parameters
        
      end
    end

    state :processing do
      event :complete, :transitions_to => :complete
      event :failed, :transitions_to => :failed
      event :repeat, :transitions_to => :processing

      on_entry do
        if timing_delay?
          if SystemConfiguration.in_effect.allow_future_deployments?
# wrap this in batch groups
            if application_ref.deployment_plan.use_batch_group_for_oos?
              CreateBatchedDeploymentsWorker.perform_in(timing_delay.hours, id)
            else
              CreateDeploymentWorker.perform_in(timing_delay.hours, id)
            end
          else
            sleep 60
            repeat!          
          end
        else
          if application_ref.deployment_plan.use_batch_group_for_oos?
            CreateBatchedDeploymentsWorker.perform_async(id)
          else
            CreateDeploymentWorker.perform_async(id)
          end
        end
      end
    end

    state :complete do
# inform creator of completion      
    end

    state :failed do
# inform creator of failure
    end
  end

  def application_ref
    Application.find_by_name(package)
  end

  def environment_ref
    Environment.find_by_name(environment)
  end

  def user_ref
    User.find_by_auth_key(auth_key)
  end

  def self.log_result(deployment_request, log)
    @l = DeploymentRequestRunLog.create(:log => log)
    deployment_request.run_logs << @l
  end

private
  def verify_package
    unless Application.all.map(&:name).include?(package)
      errors.add(:package, "must be deployable in stratus")
    end
  end

  def verify_deployment_plan
    unless Application.with_deployment_plan.include?(Application.find_by_name(package))
      errors.add(:package, "application doesn't have a deployment plan")
    end
  end

  def verify_environment
    unless Environment.all.map(&:name).include?(environment)
      errors.add(:environment, "must be deployable in stratus")
    end
    if !(SystemConfiguration.in_effect.deployable_environments.include?(environment_ref))
      errors.add(:environment, "must be deployable")
    end
  end

  def verify_auth_key
    unless User.all.map(&:auth_key).include?(auth_key)
      errors.add(:auth_key, "unknown auth_key in stratus")
    end
  end

end
