class CheckDiscSpaceWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect
    @threshold = @config.disc_space_threshold if @config.check_disc_space_deployments

    raise UserTerminatedException unless check_terminated("CheckDiscSpaceWorker", @event)

    @event.class.log_result(@event, "CheckDiscSpaceWorker::perform -> start")

    @event.servers.each do |ts|
      @task2 = "#{@ssh_cmd} check_discspace -q -t #{@threshold} -s #{ts.name}"
 
      raise UnixFailedExitException unless perform_unix_record_result("CheckDiscSpaceWorker", @event, @task2, "disc_space") 
    end

    @event.class.log_result(@event, "CheckDiscSpaceWorker::perform -> end")
    @event.class.log_result(@event, "CheckDiscSpaceWorker::perform -> SUCCESS: [disc_space: #{@event.disc_space}]")
    @event.proceed_capture_rollback_version!
  end
end
