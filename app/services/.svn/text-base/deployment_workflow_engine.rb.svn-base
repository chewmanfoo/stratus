class DeploymentWorkflowEngine
require 'sidekiq/api'
  
  def initialize(id, config_id)
    @deployment = Deployment.find(id) 
    @config = SystemConfiguration.find(config_id)
    @timer = TimerServiceDeploymentClient.new(@deployment.id, @config.id)
  end

  def create(user)
    if @deployment.auto_accept?
      accept(user)
    end
    if @deployment.auto_start?
      unless @deployment.approval_needed?
        start(user) unless user.setup_incomplete?
      end   
    end        

    send_email do
      DeploymentsMailer.delay.deployment_created(@deployment.mail_recipient, @deployment)
    end
    Deployment.log_result(@deployment, "Deployment created by #{user.given_name}")

    send_email do
      @recipient = MailRecipient.find_by_name("DeveloperServices")
      DeploymentsMailer.delay.deployment_needs_approval(@recipient, @deployment) if @deployment.approval_needed? && @recipient
    end
    true
  end
  
  def approve(current_user)
    @deployment.update_attribute(:approved_by, current_user.id)
    @deployment.update_attribute(:approved_at, Time.now)
    if @deployment.approve!
      send_email do
        DeploymentsMailer.delay.deployment_approved(@deployment.mail_recipient, @deployment)
      end
      Deployment.log_result(@deployment, "Deployment approved by #{current_user.given_name}")
      send_timing(@deployment.name, "stratus cert", "approved", "", "complete", "") 
      true
    else
      false
    end
  end

  def accept(current_user)
    @deployment.update_attribute(:accepted_by, current_user.id)
    @deployment.update_attribute(:accepted_at, Time.now)
    if @deployment.accept!
      send_email do
        DeploymentsMailer.delay.deployment_accepted(@deployment.mail_recipient, @deployment)
      end
      Deployment.log_result(@deployment, "Deployment accepted by #{current_user.given_name}")
      send_timing(@deployment.name, "stratus cert", "accepted by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def reject(current_user)
    @deployment.update_attribute(:rejected_by, current_user.id)
    @deployment.update_attribute(:rejected_at, Time.now)
    if @deployment.terminate!
      send_email do
        DeploymentsMailer.delay.deployment_rejected(@deployment.mail_recipient, @deployment)
      end
      Deployment.log_result(@deployment, "Deployment rejected by #{current_user.given_name}")
      send_timing(@deployment.name, "stratus cert", "rejected by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def start(current_user)
    @deployment.update_attribute(:started_by, current_user.id)
    @deployment.update_attribute(:started_at, Time.now)
    if @deployment.start!
      send_email do
        DeploymentsMailer.delay.deployment_started(@deployment.mail_recipient, @deployment)
      end
      Deployment.log_result(@deployment, "Deployment started by #{current_user.given_name}")
      send_timing(@deployment.name, "stratus cert", "started by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def complete(current_user)
    @deployment.update_attribute(:completed_by, current_user.id)
    @deployment.update_attribute(:completed_at, Time.now)

    if @config.show_latest_releases?
      @r = LatestRelease.find_or_create_by_name(:name => @deployment.dsl_package)
      LatestPackagesWorker.perform_async(@r.id)
    end

    if @deployment.complete!
      send_email do
        DeploymentsMailer.delay.deployment_completed(@deployment.mail_recipient, @deployment)
      end
      Deployment.log_result(@deployment, "Deployment completed by #{current_user.given_name}")
      send_timing(@deployment.name, "stratus cert", "completed by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def terminate(current_user)
    @deployment.update_attribute(:terminated_by, current_user.id)
    @deployment.update_attribute(:terminated_at, Time.now)

    if @deployment.terminate!
      do_terminate(@deployment.id)

      send_email do
        DeploymentsMailer.delay.deployment_terminated(@deployment.mail_recipient, @deployment)
      end
      Deployment.log_result(@deployment, "Deployment terminated by #{current_user.given_name}")
      send_timing(@deployment.name, "stratus cert", "terminated by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def term
    do_terminate(@deployment.id)
  end

private
  def send_email
    begin
      yield
    rescue Errno::ECONNREFUSED
      Rails.logger.info "can't connect to sendmail?"
    end if @config.send_emails?
  end

  def do_terminate(id)
    rm_arr = [id]
    rq = Sidekiq::RetrySet.new
    rq.select do |job|
      rm_arr.include?(job.args.first)
    end.map(&:delete)
  end

  def send_timing(name, speaker="stratus.crt", action, subaction, event, details)
    if @config.use_timer_service?
      if @timer.send_msg(name, speaker, action, subaction, event, details)
        Deployment.log_result(@deployment, "Deployment contacted TimerService for [name: #{name}, speaker: #{speaker}, action: #{action}, subaction: #{subaction}, event: #{event}, details: #{details}]")
      else
        Deployment.log_result(@deployment, "Deployment could not contact TimerService for [name: #{name}, speaker: #{speaker}, action: #{action}, subaction: #{subaction}, event: #{event}, details: #{details}]")
      end
    end
  end
end
