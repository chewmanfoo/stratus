class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :registerable, :recoverable
  before_save :get_ldap_parameters
  before_create :set_group_developers
  after_create:manage_default_mail_recipient

#  devise :token_authenticatable, :ldap_authenticatable, :rememberable, :trackable, :validatable
  devise :ldap_authenticatable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :given_name, 
                  :password_confirmation, :remember_me, 
                  :svn_login, :svn_password, :group_ids, :auth_key

  has_many :group_lists
  has_many :groups, :through => :group_lists
  has_many :created_refreshes, :class_name => "Refresh", :foreign_key => "created_by"
  has_many :created_deployments, :class_name => "Deployment", :foreign_key => "created_by"
  has_many :created_deployment_sets, :class_name => "DeploymentSet", :foreign_key => "created_by"
  has_many :accepted_deployments, :class_name => "Deployment", :foreign_key => "accepted_by"
  has_many :rejected_deployments, :class_name => "Deployment", :foreign_key => "rejected_by"
  has_many :started_deployments, :class_name => "Deployment", :foreign_key => "started_by"
  has_many :completed_deployments, :class_name => "Deployment", :foreign_key => "completed_by"
  has_many :approved_deployments, :class_name => "Deployment", :foreign_key => "approved_by"
  has_many :terminated_deployments, :class_name => "Deployment", :foreign_key => "terminated_by"
  belongs_to :default_mail_recipient, :class_name => "MailRecipient"

  delegate :id, :to => :default_mail_recipient, :prefix => true, :allow_nil => true

#  validates :auth_key, :uniqueness => true, :allow_nil => true
  validate :svn_password_must_be_acceptable
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/

  def self.search(search)
    if search
      find(:all, :conditions => ['given_name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def admin?
    groups.where(:admin => true).size > 0
  end

  def approves?
    groups.where(:approves => true).size > 0
  end

  def manages_users?
    groups.where(:manages_users => true).size > 0
  end

  def manages_system?
    groups.where(:manages_system => true).size > 0
  end

  def manages_database?
    groups.where(:manages_database => true).size > 0
  end

  def manages_threads?
    groups.where(:manages_threads => true).size > 0
  end

  def creates_deployments?
    groups.where(:creates_deployments => true).size > 0
  end

  def refreshes_tripcase?
    groups.where(:refreshes_tripcase => true).size > 0
  end

  def creates_switches?
    groups.where(:creates_switches => true).size > 0
  end

  def executes_deployments?
    groups.where(:executes_deployments => true).size > 0
  end

  def executes_switches?
    groups.where(:executes_switches => true).size > 0
  end

  def creates_reports?
    groups.where(:creates_reports => true).size > 0
  end

  def views_reports?
    groups.where(:views_reports => true).size > 0
  end

  def setup_incomplete?
    email.blank? || svn_login.blank? || svn_password.blank?
  end

private
  def get_ldap_parameters 
#    self.given_name = Devise::LdapAdapter.get_ldap_param(self.username,"givenname")
    self.given_name = Devise::LDAP::Adapter.get_ldap_param(self.username,"CN").first
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"uidNumber").first if self.email.blank? 
  end

  def set_group_developers
    g = Group.find_by_name("Developers")
    self.groups << g if !self.groups.include?(g)
  end

  def manage_default_mail_recipient
    if email_changed?
      if email_was == nil
        build_default_mail_recipient(:addresses => "#{self.email}", :name => "Default #{self.username}")
      else
        if default_mail_recipient.nil?
          build_default_mail_recipient(:addresses => "#{self.email}", :name => "Default #{self.username}")
        else
          default_mail_recipient.update_attribute(:addresses,"#{self.email}")
        end
      end
    end
  end

  def svn_password_must_be_acceptable
    if svn_password.present? && svn_password.include?(';')
      errors.add(:svn_password, "must be appropriate (no punctuation etc.)")
    end
  end
end
