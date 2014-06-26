class RefreshWorkflowEngine < GenericWorkflowEngine

  def initialize(id, config_id)
    @refresh = Refresh.find(id)
    @config = SystemConfiguration.find(config_id)
    @timer = TimerServiceRefreshClient.new(@refresh.id, @config.id)
  end

  def create(user)
    start(user) unless user.setup_incomplete?

#    send_email do
#      RefreshsMailer.delay.refresh_created(@refresh.mail_recipient, @refresh)
#    end
    Refresh.log_result(@refresh, "Refresh created by #{user.given_name}")

#    send_email do
#      @recipient = MailRecipient.find_by_name("DeveloperServices")
#      RefreshsMailer.delay.refresh_needs_approval(@recipient, @refresh) if @refresh.approval_needed? && @recipient
#    end
    true
  end

  def start(current_user)
    @refresh.update_attribute(:started_by, current_user.id)
    @refresh.update_attribute(:started_at, Time.now)
    if @refresh.start!
#      send_email do
#        RefreshsMailer.delay.refresh_started(@refresh.mail_recipient, @refresh)
#      end
      Refresh.log_result(@refresh, "Refresh started by #{current_user.given_name}")
      send_timing("Refresh", @refresh, @refresh.name, "stratus cert", "started by #{current_user.given_name}", "", "complete", "")
      true
    end
  end

  def complete(current_user)
    @refresh.update_attribute(:completed_at, Time.now)
    @refresh.proceed_stop!
    Refresh.log_result(@refresh, "Refresh completed by #{current_user.given_name}")
    true
  end

  def terminate(current_user)
#    @refresh.update_attribute(:terminated_by, current_user.id)
    @refresh.update_attribute(:terminated_at, Time.now)

    if @refresh.terminate!
      do_terminate(@refresh.id)

#      send_email do
#        RefreshsMailer.delay.refresh_terminated(@refresh.mail_recipient, @refresh)
#      end
      Refresh.log_result(@refresh, "Refresh terminated by #{current_user.given_name}")
      send_timing("Refresh", @refresh, @refresh.name, "stratus cert", "terminated by #{current_user.given_name}", "", "complete", "")
      true
    end
  end

  def term
    do_terminate(@refresh.id)
  end

end
