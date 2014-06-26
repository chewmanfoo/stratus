class CheckoutDeploymentWorker < GenericWorker

  def perform_checkout(worker_name, event, command)
    logger.info("#{worker_name}::perform_checkout -> executing: [#{command}]")
    @ec = true
    event.update_attribute(:in_retry, false)
    @result = `#{command} 2>&1`
    unless $?.exitstatus.zero?
      logger.info("#{worker_name}::perform_checkout -> raised UnixFailedExitException")
      logger.info("#{worker_name}::perform_checkout -> FAIL: [#{@result}]")
      event.update_attribute(:in_retry, true)
      @ec = false
    else
      if event.run_pre_checkout && event.pre_checkout.blank?
        event.update_attribute(:pre_checkout, @result)
      elsif event.run_post_checkout && event.post_checkout.blank?
        event.update_attribute(:post_checkout, @result)
      end
    end
    return @ec
  end

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("CheckoutDeploymentWorker", @event)

    logger.info("CheckoutDeploymentWorker::perform -> start")

    if @config.debug_mode?
      logger.info("CheckoutDeploymentWorker::perform -> in debug mode")
    else
      @event.servers.each do |ts|
        @task = "#{@ssh_cmd} checkout -s #{ts.name.gsub('.crt.travelocity.com','')} -x"

        raise UnixFailedExitException unless perform_checkout("CheckoutDeploymentWorker", @event, @task)
      end
    end

    logger.info("CheckoutDeploymentWorker::perform -> end")
    logger.info("CheckoutDeploymentWorker::perform -> SUCCESS: [#{@result}]")
  end

end
