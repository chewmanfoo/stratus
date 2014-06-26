class CreateBatchedDeploymentsWorker < GenericWorker

  def do_perform(id)
    @request = DeploymentRequest.find(id)
    @config = SystemConfiguration.in_effect
    @allow_deployment_requests = @config.allow_deployment_requests
    @application = Application.find(@request.application_ref)
    @success_msg = ""

    unless @allow_deployment_requests
      @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> halting because allow_deployment_requests is false")
      @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> end")
      raise GenericStopWaitException
    else
      @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> start")

      @user = User.find(@request.user_ref)

      @application.appropriate_roles.each do |r|
        e = ServersFileEngine.new
        @batches = e.find(:p_environment, @request.environment_ref.name).find(:system_role, r.name).map {|_,v| v[:batch_group]}.uniq
        if @batches.size > 0
          @batch_group = BatchGroup.create(:name => "test")
          @batches.each do |b|
            @servers = e.find(:p_environment, @request.environment_ref.name).find(:system_role, r.name).find(:sub_runtime_env, "live").find(:batch_group, b).map{|k,_| k}
            @deployment = @user.created_deployments.create(:batch => b,
                                      :application_id => @application.id,
                                      :build_number => @request.build,
                                      :run_pre_checkout => @application.deployment_plan_run_pre_checkout,
                                      :run_post_checkout => @application.deployment_plan_run_post_checkout,
                                      :auto_accept => true,
                                      :auto_start => true,
                                      :mail_recipient_id => @application.deployment_plan_mail_recipient_id,
                                      :environment_id => @request.environment_ref.id,
                                      :deployment_request_id => @request.id,
                                      :role_id => r.id)
            @deployment.set_servers(@servers)
            if @deployment.save
                @batch_group.deployments << @deployment
                s = DeploymentWorkflowEngine.new(@deployment.id, @config.id)
                if s.create(@user)
                  logger.info("Deployment #{@deployment.name} created. in workflow engine")
                end
              @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> successfully created Deployment #{@deployment.name}")
              @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> continuing")
            else
              @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> failed to create Deployment!")
              @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> end")
              raise CouldNotCreateBatchedDeploymentsException
            end
          end
        else
        end
      end

      @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> end")
      @request.class.log_result(@request, "CreateBatchedDeploymentsWorker::perform -> SUCCESS: []")
      @request.complete!
    end
  end
end
