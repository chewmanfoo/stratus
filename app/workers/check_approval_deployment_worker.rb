class CheckApprovalDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @event.update_attribute(:in_retry, false)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("CheckCobblerDeploymentWorker", @event)

    raise OutOfOrderException unless check_order("CheckApprovalDeploymentWorker", @event, "started")

    @event.class.log_result(@event, "CheckApprovalDeploymentWorker::perform -> start")

    if @event.pre_approved?
      @event.update_attribute(:in_retry, true)
      raise UnapprovedException
    else
      @result = "#{@event.full_name} approved"											
    end

    @event.class.log_result(@event, "CheckApprovalDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "CheckApprovalDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.execute!
  end

end
