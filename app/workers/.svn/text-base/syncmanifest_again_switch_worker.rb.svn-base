class SyncmanifestAgainSwitchWorker < GenericWorker

  def do_perform(event_id)
    @event = Switch.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("SyncmanifestAgainSwitchWorker", @event)

    raise OutOfOrderException unless check_order("SyncmanifestAgainSwitchWorker", @event, "syncmanifest_again")

    @event.class.log_result(@event, "SyncmanifestAgainSwitchWorker::perform -> start")

    if @config.debug_mode?
      @event.class.log_result(@event, "SyncmanifestAgainSwitchWorker::perform -> debug mode")
    else
      @task = "#{@ssh_cmd} syncmanifest -r #{@event.environment_name}"

      raise UnixFailedExitException unless perform_unix("SyncmanifestAgainSwitchWorker", @event, @task)
    end

    @event.class.log_result(@event, "SyncmanifestAgainSwitchWorker::perform -> end")
    @event.class.log_result(@event, "SyncmanifestAgainSwitchWorker::perform -> SUCCESS: [#{@result}]")
    @event.complete_review!
  end

end
