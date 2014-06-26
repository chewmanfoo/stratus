class SwitchWorkflowEngine
require 'sidekiq/api'
  
  def initialize(id, config_id)
    @switch = Switch.find(id) 
    @config = SystemConfiguration.find(config_id)
    @timer = TimerServiceSwitchClient.new(@switch, @config)
  end

  def create(user)
    if @switch.auto_accept?
      accept(user)
    end
    if @switch.auto_start?
      unless @switch.approval_needed?
        start(user)
      end   
    end        

    send_email do
      SwitchesMailer.delay.switch_created(@switch.mail_recipient, @switch)
    end
    Switch.log_result(@switch, "Switch created by #{user.given_name}")

    send_email do
      @recipient = MailRecipient.find_by_name("DeveloperServices")
      SwitchesMailer.delay.switch_needs_approval(@recipient, @switch) if @switch.approval_needed? && @recipient
    end
    true
  end
  
  def approve(current_user)
    @switch.update_attribute(:approved_by, current_user.id)
    @switch.update_attribute(:approved_at, Time.now)
    if @switch.approve!
      send_email do
        SwitchesMailer.delay.switch_approved(@switch.mail_recipient, @switch)
      end
      Switch.log_result(@switch, "Switch approved by #{current_user.given_name}")
      send_timing(@switch.name, "stratus cert", "approved", "", "complete", "") 
      true
    else
      false
    end
  end

  def accept(current_user)
    @switch.update_attribute(:accepted_by, current_user.id)
    @switch.update_attribute(:accepted_at, Time.now)
    if @switch.accept!
      send_email do
        SwitchesMailer.delay.switch_accepted(@switch.mail_recipient, @switch)
      end
      Switch.log_result(@switch, "Switch accepted by #{current_user.given_name}")
      send_timing(@switch.name, "stratus cert", "accepted by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def reject(current_user)
    @switch.update_attribute(:rejected_by, current_user.id)
    @switch.update_attribute(:rejected_at, Time.now)
    if @switch.terminate!
      send_email do
        SwitchesMailer.delay.switch_rejected(@switch.mail_recipient, @switch)
      end
      Switch.log_result(@switch, "Switch rejected by #{current_user.given_name}")
      send_timing(@switch.name, "stratus cert", "rejected by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def start(current_user)
    @switch.update_attribute(:started_by, current_user.id)
    @switch.update_attribute(:started_at, Time.now)
    if @switch.start!
      @switch.execute!
      send_email do
        SwitchesMailer.delay.switch_started(@switch.mail_recipient, @switch)
      end
      Switch.log_result(@switch, "Switch started by #{current_user.given_name}")
      send_timing(@switch.name, "stratus cert", "started by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def complete(current_user)
    @switch.update_attribute(:completed_by, current_user.id)
    @switch.update_attribute(:completed_at, Time.now)

    if @switch.complete!
      send_email do
        SwitchesMailer.delay.switch_completed(@switch.mail_recipient, @switch)
      end
      Switch.log_result(@switch, "Switch completed by #{current_user.given_name}")
      send_timing(@switch.name, "stratus cert", "completed by #{current_user.given_name}", "", "complete", "") 
      true
    end
  end

  def terminate(current_user)
    @switch.update_attribute(:terminated_by, current_user.id)
    @switch.update_attribute(:terminated_at, Time.now)

    if @switch.terminate!
      do_terminate(@switch.id)

      send_email do
        SwitchesMailer.delay.switch_terminated(@switch.mail_recipient, @switch)
      end
      Switch.log_result(@switch, "Switch terminated by #{current_user.given_name}")
      send_timing(@switch.name, "stratus cert", "terminated by #{current_user.given_name}", "", "complete", "") 
      true
    end
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
Rails.logger.info "***************************************************************************"
Rails.logger.info "* in do_terminate (id = #{id}                                             *"
Rails.logger.info "***************************************************************************"

    rm_arr = [id]
    rq = Sidekiq::RetrySet.new
    rq.select do |job|
      rm_arr.include?(job.args.first)
    end.map(&:delete)
  end

  def send_timing(name, speaker="stratus.crt", action, subaction, event, details)
    if @config.use_timer_service?
      if @timer.send_msg(name, speaker, action, subaction, event, details)
        Switch.log_result(@switch, "Switch contacted TimerService for [name: #{name}, speaker: #{speaker}, action: #{action}, subaction: #{subaction}, event: #{event}, details: #{details}]")
      else
        Switch.log_result(@switch, "Switch could not contact TimerService for [name: #{name}, speaker: #{speaker}, action: #{action}, subaction: #{subaction}, event: #{event}, details: #{details}]")
      end
    end
  end
end
