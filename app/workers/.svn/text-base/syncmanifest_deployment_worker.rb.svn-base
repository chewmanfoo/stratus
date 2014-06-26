class SyncmanifestDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("SyncmanifestDeploymentWorker", @event)

    raise OutOfOrderException unless check_order("SyncmanifestDeploymentWorker", @event, "syncmanifest")

    @event.class.log_result(@event, "SyncmanifestDeploymentWorker::perform -> start")

    if @config.debug_mode?
      @event.class.log_result(@event, "SyncmanifestDeploymentWorker::perform -> debug mode")
    else
      @task = "#{@ssh_cmd} syncmanifest -r #{@event.environment_name}"
      raise UnixFailedExitException unless perform_unix("SyncmanifestDeploymentWorker", @event, @task)
    end

    @event.class.log_result(@event, "SyncmanifestDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "SyncmanifestDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_go_oos!
  end

end
