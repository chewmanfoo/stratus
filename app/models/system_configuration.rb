class SystemConfiguration < ActiveRecord::Base
  attr_accessible :deployments_future_schedulable, :in_effect, :debug_mode, 
                  :name, :switches_future_schedulable, :send_emails,
                  :auto_approved_environment_ids, :num_latest_releases, :verify_switches,
                  :show_latest_releases, :show_latest_webapp, :allow_delete_set,
                  :check_disc_space_deployments, :disc_space_threshold, 
                  :check_reo_for_deployments_approval, :deployable_environment_ids,
                  :allow_deployment_requests, :deployment_kod, :use_timer_service, :use_oos_for_deployments,
                  :allow_auto_promotion, :enable_puppet_refresh_cron, :puppet_refresh_batchsize, :puppet_refresh_cron_timings

  has_many :auto_approval_lists
  has_many :auto_approved_environments, :class_name => "Environment", :through => :auto_approval_lists, :source => :environment

  has_many :deployable_environment_lists
  has_many :deployable_environments, :class_name => "Environment", :through => :deployable_environment_lists, :source => :environment
  validates :disc_space_threshold, :presence => true, :if => :check_disc_space_deployments?

#**********************************************************************************
# Scopes
#**********************************************************************************

  def self.in_effect
    where(:in_effect => true).first
  end

#  def in_effect=(val)
#    SystemConfiguration.all.each do |c|
#      c.update_attribute(:in_effect,false)
#    end if val == true
#    self.in_effect = val
#  end

  def self.get_latest_webapp
    @config = in_effect
    @ssh_cmd = "ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{MGMT_SERVER}"
    @task = "#{@ssh_cmd} check_webapp -s"
    @result = `#{@task}`
    @config.update_attribute(:latest_webapp,@result) 
    @config.update_attribute(:latest_webapp_at,Time.now) 
  end

  def deployment_kod_array
    deployment_kod.split(',') if deployment_kod
  end
end
