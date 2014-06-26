class OosDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect
    @skip_oos = false

    raise UserTerminatedException unless check_terminated("OosDeploymentWorker", @event)

# better: in_retry("OosDeploymentWorker")?
# be specific on *where* it is in retry
    if @event.in_retry?
      @event.class.log_result(@event, "*CheckOosDeploymentWorker::perform -> start")

      @result = true

      raise DeploymentServersUnavailableException if @event.servers.size == 0

      @event.servers.each do |ts|
        @task = "#{@ssh_cmd} /opt/operations/bin/nodes.pl --box #{ts.short_name} --status LIST|grep #{ts.short_name}|grep OOS"

# needs to verify result:
# sg0218049@tvl-c-mgmt001:~$nodes.pl --box tvl-c-wbap402 --status LIST
# Collecting box info from mcollective and DNS...
# Writing pidfile
# Starting LIST procedure on tvl-c-wbap402...
# tvl-c-wbap402 status: OOS - Out of Service.      <- grep #{ts.short_name} | grep OOS

        @result = false unless perform_unix("*CheckOosDeploymentWorker", @event, @task) 
      end

      if @result
        @event.class.log_result(@event, "*CheckOosDeploymentWorker::perform -> end")
        @event.class.log_result(@event, "*CheckOosDeploymentWorker::perform -> SUCCESS: [#{@result}]")
        @event.proceed_deploy!
        @event.update_attribute(:in_retry, false)
        @skip_oos = true
      end 
    end

    unless @skip_oos

#      raise OutOfOrderException unless check_order("OosDeploymentWorker", @event, "SOMETHING") 

      @event.class.log_result(@event, "OosDeploymentWorker::perform -> start")

      if @config.debug_mode?
        @event.class.log_result(@event, "OosDeploymentWorker::perform -> in debug mode")
      else
        @event.servers.each do |ts|
          @task = "#{@ssh_cmd} /opt/operations/bin/nodes.pl --box #{ts.short_name} --status OOS --reason #{@event.reason} :: Deploying #{@event.name}"

          raise UnixFailedExitException unless perform_unix("OosDeploymentWorker", @event, @task)
        end
      end

      @event.class.log_result(@event, "OosDeploymentWorker::perform -> end")
      @event.class.log_result(@event, "OosDeploymentWorker::perform -> SUCCESS: [#{@result}]")
      @event.proceed_check_oos!
    end
  end

end
