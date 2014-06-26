class CheckCobblerSwitchWorker < GenericWorker

  def do_perform(event_id)
    @event = Switch.find(event_id)
   
    raise UserTerminatedException unless check_terminated("CheckCobblerSwitchWorker", @event)

    raise OutOfOrderException unless check_order("CheckCobblerSwitchWorker", @event, "check_cobbler")

    @event.class.log_result(@event, "CheckCobblerSwitchWorker::perform -> start")

    @task = "#{@ssh_cmd} check_cobbler -q -s #{@event.package}"

    raise UnixFailedExitException unless perform_unix("CheckCobblerSwitchWorker", @event, @task) 

    @event.class.log_result(@event, "CheckCobblerSwitchWorker::perform -> end")
    @event.class.log_result(@event, "CheckCobblerSwitchWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed!
  end

end
