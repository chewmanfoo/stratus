class PuppetSwitchWorker < GenericWorker

  def do_perform(event_id)
# Event doesn't exist - we have Deployment and Switch - they may need STI
# or PuppetDeploymentWorker and PuppetSwitchWorker
    @event = Switch.find(event_id)
    @event.class.log_result(@event, "PuppetSwitchWorker::perform -> start")
    CheckApprovalSwitchWorker.perform_async(event_id)
    CheckCobblerSwitchWorker.perform_async(event_id)
    SvnFileSwitchWorker.perform_async(event_id)
    SyncmanifestSwitchWorker.perform_async(event_id)
    DeploySwitchWorker.perform_async(event_id)
    CheckSwitchWorker.perform_async(event_id)
    @event.class.log_result(@event, "PuppetSwitchWorker::perform -> end")
  end

end
