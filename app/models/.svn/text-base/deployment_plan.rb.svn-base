class DeploymentPlan < ActiveRecord::Base
  OOS_PERCENT_OUT = %w( 10 20 30 40 50 )

  attr_accessible :name, :application_id, :mail_recipient_id, :stop_auto_promote_environment_id,
                  :run_pre_checkout, :run_post_checkout, :use_oos_for_deployments, :oos_environment_ids,
                  :oos_percentage, :bleedoff_seconds, :use_batch_group_for_oos

  belongs_to :application
  belongs_to :mail_recipient
  belongs_to :stop_auto_promote_environment, :class_name => "Environment"

  has_many :oos_environment_lists
  has_many :oos_environments, :class_name => "Environment", :through => :oos_environment_lists, :source => :environment

  delegate :name, :to => :application, :prefix => true, :allow_nil => true
  delegate :name, :to => :mail_recipient, :prefix => true, :allow_nil => true
  delegate :name, :to => :stop_auto_promote_environment, :prefix => true, :allow_nil => true

  validates :application_id, :presence => true
  validates :mail_recipient_id, :presence => true
  validates :oos_percentage, :inclusion => { :in => DeploymentPlan::OOS_PERCENT_OUT, :on => :create }  
  validates :bleedoff_seconds, numericality: { only_integer: true }
 
end
