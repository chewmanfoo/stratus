class DeployCountermeasuresWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("DeployCountermeasuresWorker", @event)

    #raise OutOfOrderException unless check_order("DeployCountermeasuresWorker", @event, "deploy")

    @event.class.log_result(@event, "DeployCountermeasuresWorker::perform -> start")

    if @config.debug_mode?
       @event.class.log_result(@event, "DeployCountermeasuresWorker::perform -> debug mode")
    else
      @task = "#{@ssh_cmd} deploy_countermeasures -e #{@event.environment_name} -r #{@event.role_name}"

      raise UnixFailedExitException unless perform_unix("DeployCountermeasuresWorker", @event, @task)
    end

    @event.class.log_result(@event, "DeployCountermeasuresWorker::perform -> end")
    @event.class.log_result(@event, "DeployCountermeasuresWorker::perform -> SUCCESS: [#{@result}]")
  end

end
