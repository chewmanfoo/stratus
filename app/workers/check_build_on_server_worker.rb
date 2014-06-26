class CheckBuildOnServerWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)

    raise UserTerminatedException unless check_terminated("CheckBuildOnServerWorker", @event)

    @event.class.log_result(@event, "CheckBuildOnServerWorker::perform -> start")

    @event.servers.each do |ts|
      @task2 = "#{@ssh_cmd} check_build_on_server -q -s #{ts.name} -r #{@event.application_name}"

      raise UnixFailedExitException unless perform_unix_record_result("CheckBuildOnServerWorker", @event, @task2, "rollback_build_number") 
    end

    @event.class.log_result(@event, "CheckBuildOnServerWorker::perform -> end")
    @event.class.log_result(@event, "CheckBuildOnServerWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_subversion_file!
  end

end
