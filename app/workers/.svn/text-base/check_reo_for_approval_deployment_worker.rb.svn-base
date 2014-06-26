class CheckReoForApprovalDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @event.update_attribute(:in_retry, false)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("CheckREOForApprovalWorker", @event)

    @event.class.log_result(@event, "CheckREOForApprovalWorker::perform -> start")

    @task = "#{@ssh_cmd} check_reo_for_approval -q -p #{@event.reo_package} -b #{@event.reo_version}"
 
    raise UnixFailedExitException unless perform_unix("CheckREOForApprovalWorker", @event, @task) 

    @event.class.log_result(@event, "CheckREOForApprovalWorker::perform -> end")
    @event.class.log_result(@event, "CheckREOForApprovalWorker::perform -> SUCCESS: [result: #{@result}]")
    e = DeploymentWorkflowEngine.new(@event.id, @config.id)
    e.approve(@event.creator)
  end
end
