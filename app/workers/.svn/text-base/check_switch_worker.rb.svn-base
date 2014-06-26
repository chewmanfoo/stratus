class CheckSwitchWorker < GenericWorker

  def do_perform(event_id)
    @event = Switch.find(event_id)

    raise UserTerminatedException unless check_terminated("CheckSwitchWorker", @event)
    raise OutOfOrderException unless check_order("CheckSwitchWorker", @event, "check_deployment")

    @event.class.log_result(@event, "CheckSwitchWorker::perform -> start")

    if @event.deploy_to_first_server_only
      @server = @event.server_name

      @task = "#{@ssh_cmd} check_switch.pl -switch #{@event.name} -host #{@server}"

      raise UnixFailedExitException unless perform_unix("CheckSwitchWorker", @event, @task)
    else
      @event.servers.each do |ts|
        @task = "#{@ssh_cmd} /opt/operations/bin/check_switch.pl -switch #{@event.name} -host #{ts.name}"

        raise UnixFailedExitException unless perform_unix("CheckSwitchWorker", @event, @task)
      end
    end

    @event.class.log_result(@event, "CheckSwitchWorker::perform -> end")
    @event.class.log_result(@event, "CheckSwitchWorker::perform -> SUCCESS: [#{@result}]")
    if @event.default_after?
      @event.to_default_after!
    else
      @event.complete_review!
    end
  end

end
