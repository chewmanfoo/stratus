class SyncmanifestRefreshWorker < GenericWorker

  def do_perform(event_id)
    @event = Refresh.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("SyncmanifestRefreshWorker", @event)

    raise OutOfOrderException unless check_order("SyncmanifestRefreshWorker", @event, "syncmanifest")

    @event.class.log_result(@event, "SyncmanifestRefreshWorker::perform -> start")

    if @config.debug_mode?
      @event.class.log_result(@event, "SyncmanifestRefreshWorker::perform -> debug mode")
    else
      @task = "#{@ssh_cmd} syncmanifest -r #{@event.environment_name}"
      raise UnixFailedExitException unless perform_unix("SyncmanifestRefreshWorker", @event, @task)
    end

    @event.class.log_result(@event, "SyncmanifestRefreshWorker::perform -> end")
    @event.class.log_result(@event, "SyncmanifestRefreshWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_deploy!
  end

end
