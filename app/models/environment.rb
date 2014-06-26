class Environment < ActiveRecord::Base
  attr_accessible :name, :next_environment_id, :requires_reason, :tcs_environment

  has_many :deployments
  belongs_to :next_environment, :class_name => "Environment"
  has_many :auto_approval_lists
  has_many :auto_approved_system_configurations, :class_name => "SystemConfiguration", :through => :auto_approval_lists, :source => :system_configuration
  has_many :deployable_environment_lists
  has_many :deployable_environment_system_configurations, :class_name => "SystemConfiguration", :through => :deployable_environment_lists, :source => :system_configuration
  has_many :deployment_set_environment_lists
  has_many :deployment_sets, :through => :deployment_set_environment_lists
  has_many :oos_environment_lists
  has_many :oos_environment_application_plans, :class_name => "DeploymentPlan", :through => :oos_environment_lists, :source => :deployment_plan

#need something for deployment_plan.stop_auto_promote_environment

  delegate :name, :to => :next_environment, :prefix => true, :allow_nil => true

  validates :name, :uniqueness => true

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :sorted_by_name, :conditions => ["name is NOT NULL"], :order => "name"
  scope :tcs, where(:tcs_environment => true)

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def svn_path
     "http://#{SVN_SERVER}/#{PUPPET_PATH}/#{name}/conf"
  end

  def svn_file
    "applications.csv"
  end

end
