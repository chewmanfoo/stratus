class Role < ActiveRecord::Base
  attr_accessible :name, :tcs_role

  has_many :deployments
  has_many :appropriate_roles_applications
  has_many :applications, :through => :appropriate_roles_applications, :source => :application
  has_many :deployment_set_role_lists
  has_many :deployment_sets, :through => :deployment_set_role_lists

  validates :name, :uniqueness => true

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :sorted_by_name, :conditions => ["name is NOT NULL"], :order => "name"
  scope :tcs, where(:tcs_role => true) 

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
