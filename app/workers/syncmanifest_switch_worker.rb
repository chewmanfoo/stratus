class SyncmanifestSwitchWorker < GenericWorker

  def do_perform(event_id)
    @event = Switch.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("SyncmanifestSwitchWorker", @event)

    raise OutOfOrderException unless check_order("SyncmanifestSwitchWorker", @event, "syncmanifest")

    @event.class.log_result(@event, "SyncmanifestSwitchWorker::perform -> start")

    if @config.debug_mode?
      @event.class.log_result(@event, "SyncmanifestSwitchWorker::perform -> debug mode")
    else
      @task = "#{@ssh_cmd} syncmanifest -r #{@event.environment_name}"

      raise UnixFailedExitException unless perform_unix("SyncmanifestSwitchWorker", @event, @task)
    end

    @event.class.log_result(@event, "SyncmanifestSwitchWorker::perform -> end")
    @event.class.log_result(@event, "SyncmanifestSwitchWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed!
  end

end
