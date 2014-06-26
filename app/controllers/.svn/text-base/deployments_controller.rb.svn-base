class DeploymentsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def clone
    @new_deployment = @deployment.dup
    @deployment = @new_deployment
    @deployment.deployment_timings.delete_all
    render :action => "new"
  end

  def rollback 
    @new_deployment = @deployment.dup
    @deployment = @new_deployment
    @deployment.build_number = @deployment.rollback_build_number
    @deployment.rollback_build_number = ""
    render :action => "new"
  end

  def get_help
    send_email do
      OperationsHelperMailer.delay.deployment_needs_help(current_user.id, @deployment.id)
    end
  
    @deployment.update_attribute(:devsvcs_help_email_sent, true)
    redirect_to(@deployment, :notice => "DevServices has been notified.")
  end

  def promote 
    @new_deployment = @deployment.dup
    @deployment = @new_deployment
    @deployment.rollback_build_number = ""
    @deployment.environment = @deployment.environment.next_environment
    render :action => "new"
  end

  def proceed
    @deployment = Deployment.find(params[:id])
    if @deployment.current_state > :started && @deployment.current_state < :complete_review
      case @deployment.current_state.to_s
        when "check_disc_space"
          @deployment.proceed_capture_rollback_version!
        when "capture_rollback_version"
          @deployment.proceed_subversion_file!
        when "subversion_file"
          @deployment.proceed_syncmanifest!
        when "syncmanifest"
          @deployment.proceed_go_oos!
        when "deploy"
          @deployment.proceed_check_deployment!
        when "redeploy"
          @deployment.proceed_check_deployment!
        when "check_deployment"
          @deployment.complete!
      end
      msg = "Successful proceed"
      redirect_to(root_url, :notice => msg)
    else
      msg = "Can't proceed"
      redirect_to(root_url, :error => msg)
    end
  end

  def send_email
    begin
      yield
    rescue Errno::ECONNREFUSED
      logger.info "can't connect to sendmail?"
    end if @config.send_emails?
  end

  def create
    @deployment = current_user.created_deployments.create(params[:deployment])

    if @deployment.save
      e = DeploymentWorkflowEngine.new(@deployment.id, @config.id)

      respond_to do |format|
        if e.create(current_user)
          format.html { redirect_to(@deployment, :notice => "Deployment was successfully created.") }
          format.json { render :json => @deployment, :status => :created, :location => @deployment }
        else
          format.html { render :action => "new" }
          format.json { render :json => @deployment.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def approve
    if @deployment
      e = DeploymentWorkflowEngine.new(@deployment.id, @config.id)
 
      if @deployment.awaiting_approval?
        if e.approve(current_user)
          flash[:notice] = "You have successfully approved this Deployment."
          redirect_to root_url
        else
          flash[:error] = "There was a problem with approving this Deployment!"
          redirect_to deployments_path
        end
      else
        redirect_to(@deployment, :error => "Deployment can't be approved.")
      end
    else
      flash[:error] = "That Deployment was not found.  Check your work!"
      redirect_to deployments_path
    end
  end

  def terminate
    if @deployment
      e = DeploymentWorkflowEngine.new(@deployment.id, @config.id)

      if @deployment.current_state > :started && @deployment.current_state < :complete
        if e.terminate(current_user)
          flash[:notice] = "You have successfully terminated this Deployment."
          redirect_to root_url
        else
          flash[:error] = "There was a problem with terminating this Deployment!"
          redirect_to deployments_path
        end
      else
        redirect_to(@deployment, :error => "Deployment can't be terminated.")
      end
    else
      flash[:error] = "That Deployment was not found.  Check your work!"
      redirect_to deployments_path
    end
  end

  def accept
    if @deployment
      e = DeploymentWorkflowEngine.new(@deployment.id, @config.id)
      
      if @deployment.new? || @deployment.awaiting_acceptance?
        if e.accept(current_user)
          flash[:notice] = "You have successfully accepted this Deployment."
          redirect_to root_url
        else
          flash[:error] = "There was a problem with accepting this Deployment!"
          redirect_to deployments_path
        end
      else
        redirect_to(@deployment, :error => "Deployment can't be accepted.")
      end
    else
      flash[:error] = "That Deployment was not found.  Check your work!"
      redirect_to deployments_path
    end
  end

  def start 
    if @deployment
      if current_user.setup_incomplete?
        flash[:error] = "You can't start Deployments until your user account setup is complete."
        redirect_to root_url
      else
        e = DeploymentWorkflowEngine.new(@deployment.id, @config.id)

        if @deployment.awaiting_approval? || @deployment.approved?
          if e.start(current_user) 
            flash[:notice] = "You have successfully started this Deployment."
            redirect_to root_url
          else
            flash[:error] = "There was a problem with starting this Deployment!"
            redirect_to deployments_path
          end
        else
          redirect_to(@deployment, :error => "Deployment can't be started.")
        end
      end
    else
      flash[:error] = "That Deployment was not found.  Check your work!"
      redirect_to deployments_path
    end
  end

  def complete
    if @deployment
      e = DeploymentWorkflowEngine.new(@deployment.id, @config.id)

      if @deployment.current_state > :deploy && @deployment.current_state < :complete
        if e.complete(current_user)
          flash[:notice] = "You have successfully completed this Deployment."
          redirect_to root_url
        else
          flash[:error] = "There was a problem with completing this Deployment!"
          redirect_to deployments_path
        end
      else
        redirect_to(@deployment, :error => "Deployment can't be completed.")
      end
    else
      flash[:error] = "That Deployment was not found.  Check your work!"
      redirect_to deployments_path
    end
  end

  def reject
    if @deployment
      e = DeploymentWorkflowEngine.new(@deployment.id, @config.id)

      if e.reject(current_user)
        flash[:notice] = "You have successfully rejected this Deployment."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with rejecting this Deployment!"
        redirect_to deployments_path
      end
    else
      flash[:error] = "That Deployment was not found.  Check your work!"
      redirect_to deployments_path
    end
  end

  def index
    @deployments = Deployment.paginate(:page => params[:page], :per_page => 7, :order => "created_at DESC")

    respond_to do |f|
      f.html
      f.json
      f.xml
    end
  end

  def show
    @use_help_mailer = true unless @deployment.devsvcs_help_email_sent?
    if @deployment
      respond_to do |f|
        f.html
        f.json
        f.xml
      end
    else
      flash[:error] = "Could not find that Deployment!"
      redirect_to root_url
    end
  end

  def rollup
    @deployments = Deployment.landed
  
    @deployments.each do |d|
      e = DeploymentWorkflowEngine.new(d.id, @config.id)

      if d.current_state > :deploy && d.current_state < :complete
        if e.complete(current_user)
          e.term
          flash[:notice] = "You have successfully completed #{ActionController::Base.helpers.pluralize(@deployments.size, 'Deployment')}." 
        else
          flash[:error] = "There was a problem with completing Deployment(s). "
        end      
      end
    end

    redirect_to root_url
  end

private
  def setup
    @start_datetime = Time.now
#    @deployments = Deployment.all.sort_by(&:created_at)
#    @applications = Application.find(:all, :select => 'name, id')
#    @roles = Role.all.sort_by(&:name)
#    @environments = Environment.all.sort_by(&:name)
#    @mail_recipients = MailRecipient.all.sort_by(&:name)
    @applications = Application.sorted_by_name
    @roles = Role.sorted_by_name
    @environments = Environment.sorted_by_name
    @mail_recipients = MailRecipient.sorted_by_name
    @deployment = Deployment.find(params[:id]) if params[:id]
    @config = SystemConfiguration.in_effect
    @useful_links = UsefulLink.sorted_by_name
    @latest_releases = LatestRelease.latest_batch
    @rubyver = `ruby -v`.gsub("\n","")
    @railsver = `rails -v`.gsub("\n","")
    @railsenv = `echo $RAILS_ENV`
    @sidekiqstat = `ps -ef | grep sidekiq|grep -v grep|awk '{print $8" "$9" "$10" "$11" "$12" "$13" "$14}'`
    @sidekiqpex = `ps -ef | grep sidekiq|grep -v grep`
    @sidekiqex = $?.exitstatus
  end
end
