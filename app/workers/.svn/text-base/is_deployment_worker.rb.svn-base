class IsDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect
    @skip_is = false

    raise UserTerminatedException unless check_terminated("IsDeploymentWorker", @event)

# better: in_retry("IsDeploymentWorker")?
# be specific on *where* it is in retry
    if @event.in_retry?
      @event.class.log_result(@event, "*CheckIsDeploymentWorker::perform -> start")

      @result = true

      raise DeploymentServersUnavailableException if @event.servers.size == 0

      @event.servers.each do |ts|
        @task = "#{@ssh_cmd} /opt/operations/bin/nodes.pl --box #{ts.short_name} --status LIST|grep #{ts.short_name}|grep IS"

# needs to verify result:
# sg0218049@tvl-c-mgmt001:~$nodes.pl --box tvl-c-wbap402 --status LIST
# Collecting box info from mcollective and DNS...
# Writing pidfile
# Starting LIST procedure on tvl-c-wbap402...
# tvl-c-wbap402 status: IS - In Service.      <- grep #{ts.short_name} | grep IS

        @result = false unless perform_unix("*CheckIsDeploymentWorker", @event, @task) 
      end

      if @result
        @event.class.log_result(@event, "*CheckIsDeploymentWorker::perform -> end")
        @event.class.log_result(@event, "*CheckIsDeploymentWorker::perform -> SUCCESS: [#{@result}]")
        @event.complete_review!
        @event.update_attribute(:in_retry, false)
        @skip_is = true
      end 
    end

    unless @skip_is

#      raise OutOfOrderException unless check_order("IsDeploymentWorker", @event, "SOMETHING") 

      @event.class.log_result(@event, "IsDeploymentWorker::perform -> start")

      if @config.debug_mode?
        @event.class.log_result(@event, "IsDeploymentWorker::perform -> in debug mode")
      else
        @event.servers.each do |ts|
          @task = "#{@ssh_cmd} /opt/operations/bin/nodes.pl --box #{ts.short_name} --status IS --reason #{@event.reason} :: Deployment complete #{@event.name}"

          raise UnixFailedExitException unless perform_unix("IsDeploymentWorker", @event, @task)
        end
      end

      @event.class.log_result(@event, "IsDeploymentWorker::perform -> end")
      @event.class.log_result(@event, "IsDeploymentWorker::perform -> SUCCESS: [#{@result}]")
      @event.proceed_check_is!
    end
  end

end
