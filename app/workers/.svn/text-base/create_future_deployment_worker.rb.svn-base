class CreateFutureDeploymentWorker < GenericWorker

  def do_perform(parameters)
# note these can only be CERT4 (non_approvable) Deployments
    @event = Deployment.new(parameters)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("CreateFutureDeploymentWorker", @event)

    raise FutureDeploymentCreationException unless @event.save

    @event.class.log_result(@event, "CreateFutureDeploymentWorker::perform -> start")

    @event.class.log_result(@event, "CreateFutureDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "CreateFutureDeploymentWorker::perform -> SUCCESS")
    @event.proceed!
  end

end
