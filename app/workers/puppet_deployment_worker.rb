class PuppetDeploymentWorker < GenericWorker

  def do_perform(event_id)
# Event doesn't exist - we have Deployment and Switch - they may need STI
# or PuppetDeploymentWorker and PuppetSwitchWorker
    @event = Deployment.find(event_id)
    @event.class.log_result(@event, "PuppetDeploymentWorker::perform -> start")
    CheckApprovalDeploymentWorker.perform_async(event_id)
    CheckCobblerDeploymentWorker.perform_async(event_id)
    SvnFileDeploymentWorker.perform_async(event_id)
    SyncmanifestDeploymentWorker.perform_async(event_id)
    DeployDeploymentWorker.perform_async(event_id)
    CheckDeploymentWorker.perform_async(event_id)
    @event.class.log_result(@event, "PuppetDeploymentWorker::perform -> end")
  end

end
