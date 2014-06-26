class CheckIsDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)

    raise UserTerminatedException unless check_terminated("CheckIsDeploymentWorker", @event)
 
    raise OutOfOrderException unless check_order("CheckIsDeploymentWorker", @event, "check_is")

    @event.class.log_result(@event, "CheckIsDeploymentWorker::perform -> start")
    @event.class.log_result(@event, "CheckIsDeploymentWorker::perform -> debug: @event.id = #{@event.id}")

    @event.servers.each do |ts|
      @task = "#{@ssh_cmd} /opt/operations/bin/nodes.pl --box #{ts.short_name} --status LIST|grep #{ts.short_name}|grep ' IS'"

      unless perform_unix("CheckIsDeploymentWorker", @event, @task)
        @event.class.log_result(@event, "CheckIsDeploymentWorker::FAIL server #{ts.short_name} is NOT IS")
      end
    end

    @event.class.log_result(@event, "CheckIsDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "CheckIsDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.complete_review!
  end

end
