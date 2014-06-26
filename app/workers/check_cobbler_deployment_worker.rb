class CheckCobblerDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
   
    raise UserTerminatedException unless check_terminated("CheckCobblerDeploymentWorker", @event)

    raise OutOfOrderException unless check_order("CheckCobblerDeploymentWorker", @event, "check_cobbler")

    @event.class.log_result(@event, "CheckCobblerDeploymentWorker::perform -> start")

    @task = "#{@ssh_cmd} check_cobbler -q -r #{@event.package}"

    raise UnixFailedExitException unless perform_unix("CheckCobblerDeploymentWorker", @event, @task) 

    @event.class.log_result(@event, "CheckCobblerDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "CheckCobblerDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_check_disc_space!
  end

end
