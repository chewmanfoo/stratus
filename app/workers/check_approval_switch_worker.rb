class CheckApprovalSwitchWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @event.update_attribute(:in_retry, false)
   
    raise OutOfOrderException unless check_order("CheckApprovalSwitchWorker", @event, "started")

    @event.class.log_result(@event, "CheckApprovalSwitchWorker::perform -> start")

    unless @event.approved
      @event.update_attribute(:in_retry, true)
      raise UnapprovedException 
    end

    @event.class.log_result(@event, "CheckApprovalSwitchWorker::perform -> end")
    @event.class.log_result(@event, "CheckApprovalSwitchWorker::perform -> SUCCESS: [#{@result}]")
    @event.execute!
  end

end
