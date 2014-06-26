class DeployDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect
    @skip_deployment = false

    raise UserTerminatedException unless check_terminated("DeployDeploymentWorker", @event)

    if @event.in_retry?
      @event.class.log_result(@event, "*CheckDeploymentWorker::perform -> start")

      @result = true

      raise DeploymentServersUnavailableException if @event.servers.size == 0

      @event.servers.each do |ts|
        @task = "#{@ssh_cmd} ssh -q -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' #{ts.name} rpm -q #{@event.package}"
        @task2 = "#{@ssh_cmd} ssh -q -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' #{ts.name} rpm -q #{@event.application_name}"

        @result = false unless perform_unix("*CheckDeploymentWorker", @event, @task) || perform_unix_verify_result("*CheckDeploymentWorker", @event, @task2, "greater", @event.package)
      end

      if @result
        @event.class.log_result(@event, "*CheckDeploymentWorker::perform -> end")
        @event.class.log_result(@event, "*CheckDeploymentWorker::perform -> SUCCESS: [#{@result}]")
        @event.proceed_go_is!
        @event.update_attribute(:in_retry, false)
        @skip_deployment = true
      end 
    end

    unless @skip_deployment

      raise OutOfOrderException unless check_order("DeployDeploymentWorker", @event, "deploy") || check_order("DeployDeploymentWorker", @event, "redeploy")

      @event.class.log_result(@event, "DeployDeploymentWorker::perform -> start")

      if @config.debug_mode?
        @event.class.log_result(@event, "DeployDeploymentWorker::perform -> in debug mode")
      else
        @event.servers.each do |ts|
          @task = "#{@ssh_cmd} deploy -s '$(srvrs -e #{@event.environment_name} -r #{@event.role_name} -f mco)' -f"
#          @task = "#{@ssh_cmd} deploy -s #{ts.name.gsub('.crt.travelocity.com','')} -f"

          raise UnixFailedExitException unless perform_unix("DeployDeploymentWorker", @event, @task)
        end
      end

      @event.class.log_result(@event, "DeployDeploymentWorker::perform -> end")
      @event.class.log_result(@event, "DeployDeploymentWorker::perform -> SUCCESS: [#{@result}]")
      @event.proceed_check_deployment!
    end
  end

end
