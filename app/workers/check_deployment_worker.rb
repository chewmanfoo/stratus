class CheckDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)

    raise UserTerminatedException unless check_terminated("CheckDeploymentWorker", @event)
 
    raise OutOfOrderException unless check_order("CheckDeploymentWorker", @event, "check_deployment")

    @event.class.log_result(@event, "CheckDeploymentWorker::perform -> start")

    @event.servers.each do |ts|
#      @task = "#{@ssh_cmd} ssh -q -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' #{ts.name} rpm -q #{@event.package}"
#      @task2 = "#{@ssh_cmd} ssh -q -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' #{ts.name} rpm -q #{@event.application_name}"

      @task = "sudo #{@ssh_cmd} ssh -q -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' #{ts.name} rpm -q #{@event.package}"
      @task2 = "sudo #{@ssh_cmd} ssh -q -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' #{ts.name} rpm -q #{@event.application_name}"

      unless perform_unix("CheckDeploymentWorker", @event, @task)
        @event.class.log_result(@event, "CheckDeploymentWorker::FAIL server #{ts} doesn't contain the exact package")
        unless perform_unix_verify_result("CheckDeploymentWorker", @event, @task2, "greater", @event.package) 
          @event.class.log_result(@event, "CheckDeploymentWorker::FAIL server #{ts} doesn't contain greater package")
          @event.proceed_redeploy! 
        end
        raise UnixFailedExitException
      end
    end

    @event.class.log_result(@event, "CheckDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "CheckDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_go_is!
  end

end
