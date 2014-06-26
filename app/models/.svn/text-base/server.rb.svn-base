class Server < ActiveRecord::Base
  attr_accessible :batch_group, :classes, :environment_id, :name, :role_id, 
                  :runtime_env, :sub_runtime_env, :switches, :inactive

  belongs_to :environment
  belongs_to :role
  

  delegate :name, :to => :role, :prefix => true, :allow_nil => true
  delegate :name, :to => :environment, :prefix => true, :allow_nil => true

  validates :name, :uniqueness => true
#  validates :role_id, :environment_id, :presence => true

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :by_environment_and_role_and_runtime_env, lambda { |e, r, t| where("environment_id = ? and role_id = ? and runtime_env = ?", e, r, t)}

  scope :active_by_environment_and_role_and_runtime_env, lambda { |e, r, t| where("environment_id = ? and role_id = ? and runtime_env = ? and (inactive is NULL or inactive = 0)", e, r, t)}

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def deployable?
    SystemConfiguration.in_effect.deployable_environments.include?(environment)
  end

  def short_name
    name.split('.').first
  end
end
