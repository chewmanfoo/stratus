class CheckConcurrentDeploymentWorker < GenericWorker

  def do_perform(event_id)
    @event = Deployment.find(event_id)

    raise UserTerminatedException unless check_terminated("CheckConcurrentDeploymentWorker", @event)
 
    raise OutOfOrderException unless check_order("CheckConcurrentDeploymentWorker", @event, "check_concurrent_deployment")

    @event.class.log_result(@event, "CheckConcurrentDeploymentWorker::perform -> start")

    @other_events = Deployment.inflight.concurrent(@event.application_id, @event.role_id, @event.environment_id)
    @event.class.log_result(@event, "CheckConcurrentDeploymentWorker::perform -> there are #{@other_events.size - 1} concurrent Deployments")
    @result = ""

    @other_events.each do |e|
      unless e.id == @event.id 
        if e.build_number < @event.build_number
          @result << "#{e.name} terminated by CheckConcurrentDeploymentWorker because #{e.id} != #{@event.id} and #{e.build_number} < #{@event.build_number}"
          e.terminate!
        end
      end
    end

    @event.class.log_result(@event, "CheckConcurrentDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "CheckConcurrentDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_check_cobbler!
  end

end
