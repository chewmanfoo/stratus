class CheckOosDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)

    raise UserTerminatedException unless check_terminated("CheckOosDeploymentWorker", @event)
 
#    raise OutOfOrderException unless check_order("CheckOosDeploymentWorker", @event, "check_oos")

    @event.class.log_result(@event, "CheckOosDeploymentWorker::perform -> start")

    @event.servers.each do |ts|
      @task = "#{@ssh_cmd} /opt/operations/bin/nodes.pl --box #{ts.short_name} --status LIST|grep #{ts.short_name}|grep OOS"
      unless perform_unix("CheckOosDeploymentWorker", @event, @task)
        @event.class.log_result(@event, "CheckOosDeploymentWorker::FAIL server #{ts} is NOT OOS")
      end
    end

    @event.class.log_result(@event, "CheckOosDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "CheckOosDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_bleedoff!
  end

end
