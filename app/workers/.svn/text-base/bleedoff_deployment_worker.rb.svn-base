class BleedoffDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("BleedoffDeploymentWorker", @event)

    raise OutOfOrderException unless check_order("BleedoffDeploymentWorker", @event, "bleedoff")

    @event.class.log_result(@event, "BleedoffDeploymentWorker::perform -> start")

    if @config.debug_mode?
      @event.class.log_result(@event, "BleedoffDeploymentWorker::perform -> debug mode")
    else
      @task = "sleep #{@event.bleedoff_seconds}"
      raise UnixFailedExitException unless perform_unix("BleedoffDeploymentWorker", @event, @task)
    end

    @event.class.log_result(@event, "BleedoffDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "BleedoffDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_deploy!
  end

end
