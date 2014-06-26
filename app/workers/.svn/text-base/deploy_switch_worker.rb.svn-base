class DeploySwitchWorker < GenericWorker

  def do_perform(event_id)
    @event = Switch.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("DeploySwitchWorker", @event)

    raise OutOfOrderException unless check_order("DeploySwitchWorker", @event, "deploy")

    @event.class.log_result(@event, "DeploySwitchWorker::perform -> start")

    if @config.debug_mode?
       @event.class.log_result(@event, "DeploySwitchWorker::perform -> debug mode")
    else
      if @event.deploy_to_first_server_only
        @server = @event.server_name

        @task = "#{@ssh_cmd} deploy -s #{@event.server_name.gsub('.crt.travelocity.com','')} -f"

        raise UnixFailedExitException unless perform_unix("DeploySwitchWorker", @event, @task)
      else
        @event.servers.each do |ts|
          @task = "#{@ssh_cmd} deploy -s #{ts.name.gsub('.crt.travelocity.com','')} -f"

          raise UnixFailedExitException unless perform_unix("DeploySwitchWorker", @event, @task)
        end
      end

    end

    @event.class.log_result(@event, "DeploySwitchWorker::perform -> end")
    @event.class.log_result(@event, "DeploySwitchWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed!
  end

end
