class Application < ActiveRecord::Base
  attr_accessible :name, :version, :appropriate_role_ids, :check_reo_for_approval

  has_many :deployments
  has_one :deployment_plan
  has_many :appropriate_roles_applications
  has_many :appropriate_roles, :through => :appropriate_roles_applications, :class_name => "Role", :source => :role, :uniq => true
  has_many :jump_page_links, :dependent => :destroy
  accepts_nested_attributes_for :jump_page_links, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true  

  validates :name, :uniqueness => true
  validates :version, :presence => true
  validates_associated :jump_page_links

  delegate :name, :to => :deployment_plan, :prefix => true, :allow_nil => true
  delegate :run_pre_checkout, :to => :deployment_plan, :prefix => true, :allow_nil => true
  delegate :run_post_checkout, :to => :deployment_plan, :prefix => true, :allow_nil => true
  delegate :mail_recipient_id, :to => :deployment_plan, :prefix => true, :allow_nil => true
  delegate :use_oos_for_deployments, :to => :deployment_plan, :prefix => false, :allow_nil => true

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :with_deployment_plan, joins(:deployment_plan)
  scope :sorted_by_name, :conditions => ["name is NOT NULL"], :order => "name"

  def use_oos_for_deployments?
    use_oos_for_deployments
  end

  def oos_environments
    deployment_plan.oos_environments
  end

  def oos_environment?(e)
    deployment_plan.oos_environments.include?(e)
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def servers
    Server.find_all_by_role_id(appropriate_roles.map(&:id))
  end
end
