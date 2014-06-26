class DeployRefreshWorker < GenericWorker

  def do_perform(event_id)
    @event = Refresh.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("DeployRefreshWorker", @event)

    raise OutOfOrderException unless check_order("DeployRefreshWorker", @event, "deploy")

    @event.class.log_result(@event, "DeployRefreshWorker::perform -> start")

    if @config.debug_mode?
       @event.class.log_result(@event, "DeployRefreshWorker::perform -> debug mode")
    else
      @event.servers.each do |ts|
        @task = "#{@ssh_cmd} deploy -s #{ts.name.gsub('.crt.travelocity.com','')} -f"

        raise UnixFailedExitException unless perform_unix("DeployRefreshWorker", @event, @task)
      end
    end

    @event.class.log_result(@event, "DeployRefreshWorker::perform -> end")
    @event.class.log_result(@event, "DeployRefreshWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_complete!
  end

end
