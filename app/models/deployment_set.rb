class DeploymentSet < ActiveRecord::Base
  attr_accessible :application_id, :auto_accept, :auto_start, :build_number, :changelist, 
                  :created_by, :run_post_checkout, :run_pre_checkout, :mail_recipient_id,
                  :environment_ids, :role_ids

  belongs_to :application
  belongs_to :mail_recipient
  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  has_many :deployment_set_role_lists
  has_many :roles, :through => :deployment_set_role_lists
  has_many :deployment_set_environment_lists
  has_many :environments, :through => :deployment_set_environment_lists
  has_many :deployments

  delegate :given_name, :to => :creator, :prefix => true, :allow_nil => true
  delegate :email, :to => :creator, :prefix => true, :allow_nil => true 
  delegate :name, :to => :application, :prefix => true, :allow_nil => true
  delegate :appropriate_roles, :to => :application, :prefix => false, :allow_nil => false

  validates :application_id, :presence => true
  validate :must_be_deployable_environments
  validate :must_be_appropriate_roles
  validates :build_number, :presence => true
  validates :build_number, :format => { :with => /\d+\-\d+/,
    :message => "must contain build#-version.  Typically this is something-1." }
  validates :mail_recipient_id, :presence => true

protected
  def must_be_deployable_environments
    environments.each do |e|
      if !(SystemConfiguration.in_effect.deployable_environments.include?(e))
        errors.add(:environments, "must be deployable")
      end
    end
  end

  def must_be_appropriate_roles
    roles.each do |r|
      unless appropriate_roles.include?(r)
        errors.add(:roles, "must be appropriate for this application")
      end
    end
  end
end
