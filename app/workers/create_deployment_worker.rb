class CreateDeploymentWorker < GenericWorker

  def do_perform(id)
    @request = DeploymentRequest.find(id)
    @config = SystemConfiguration.in_effect
    @allow_deployment_requests = @config.allow_deployment_requests
    @application = Application.find(@request.application_ref)

    unless @allow_deployment_requests
      @request.class.log_result(@request, "CreateDeploymentWorker::perform -> halting because allow_deployment_requests is false")
      @request.class.log_result(@request, "CreateDeploymentWorker::perform -> end")
      raise GenericStopWaitException
    else
      @request.class.log_result(@request, "CreateDeploymentWorker::perform -> start")

      @user = User.find(@request.user_ref)

      @application.appropriate_roles.each do |r|
        @deployment = @user.created_deployments.create(:application_id => @application.id,
                                  :build_number => @request.build,
                                  :run_pre_checkout => @application.deployment_plan_run_pre_checkout,
                                  :run_post_checkout => @application.deployment_plan_run_post_checkout,
                                  :auto_accept => true,
                                  :auto_start => true,
                                  :mail_recipient_id => @application.deployment_plan_mail_recipient_id,
                                  :environment_id => @request.environment_ref.id,
                                  :deployment_request_id => @request.id,
                                  :role_id => r.id)
        if @deployment.save
            s = DeploymentWorkflowEngine.new(@deployment.id, @config.id)
            if s.create(@user)
              logger.info("Deployment #{@deployment.name} created. in workflow engine")
            end
          @request.class.log_result(@request, "CreateDeploymentWorker::perform -> successfully created Deployment #{@deployment.name}")
          @request.class.log_result(@request, "CreateDeploymentWorker::perform -> continuing")
        else
          @request.class.log_result(@request, "CreateDeploymentWorker::perform -> failed to create Deployment!")
          @request.class.log_result(@request, "CreateDeploymentWorker::perform -> end")
          raise CouldNotCreateDeploymentException
        end
      end

      @request.class.log_result(@request, "CreateDeploymentWorker::perform -> end")
      @request.class.log_result(@request, "CreateDeploymentWorker::perform -> SUCCESS: []")
      @request.complete!
    end
  end
end
