class EnvironmentSyncReportsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def clone
    @new_environment_sync_report = @environment_sync_report.dup
    @environment_sync_report = @new_environment_sync_report
    render :action => "new"
  end

  def rerun
    @new_environment_sync_report = @environment_sync_report.dup
    @environment_sync_report = @new_environment_sync_report
    if @environment_sync_report.save
      @environment_sync_report.reset!
      @environment_sync_report.update_attribute(:started_by, current_user.id)
      @environment_sync_report.update_attribute(:started_at, Time.now)
      @environment_sync_report.start!
      flash[:notice] = "You have successfully rerun this EnvironmentSyncReport."
      redirect_to root_url
    else
      flash[:error] = "Something went wrong.  We could not rerun this report!"
      redirect_to environment_sync_reports_path
    end
  end

  def send_email
    begin
      yield
    rescue Errno::ECONNREFUSED
      logger.info "can't connect to sendmail?"
    end if @config.send_emails?
  end

  def start
    if @environment_sync_report
      @environment_sync_report.update_attribute(:started_by, current_user.id)
      @environment_sync_report.update_attribute(:started_at, Time.now)
      @environment_sync_report.start!

      if @environment_sync_report.save
        EnvironmentSyncReport.log_result(@environment_sync_report, "EnvironmentSyncReport started by #{current_user.given_name}")
#        send_email do
#          EnvironmentSyncReportsMailer.environment_sync_report_started(@environment_sync_report.mail_recipient, @environment_sync_report)
#        end

        flash[:notice] = "You have successfully started this EnvironmentSyncReport."
        redirect_to @environment_sync_report 
      else
        flash[:error] = "There was a problem with starting this EnvironmentSyncReport!"
        redirect_to environment_sync_reports_path
      end
    else
      flash[:error] = "That EnvironmentSyncReport was not found.  Check your work!"
      redirect_to environment_sync_reports_path
    end
  end

  def show
    respond_to do |format|
      format.html 
      format.csv do
        render_csv("#{@environment_sync_report.name}-#{Time.now.strftime("%Y%m%d")}") 
      end
    end
  end

  def render_csv(filename = nil)
    filename ||= params[:action]
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
    end

    render :layout => false
  end

  def correct
    case params[:do]
      when "deploy trust to target"
        create_deployment(params[:application], params[:trust_version], params[:target_env_id])
      when "deploy target to trust"
        create_deployment(params[:application], params[:target_version], params[:trust_env_id])
    end
    flash[:notice] = @success_msg
    redirect_to @environment_sync_report
  end

private
  def setup
    @start_datetime = Time.now
    @environment_sync_report = EnvironmentSyncReport.find(params[:id]) if params[:id]
    @config = SystemConfiguration.in_effect
    @useful_links = UsefulLink.all.sort_by(&:name)
    @latest_releases = LatestRelease.latest_batch
    @rubyver = `ruby -v`.gsub("\n","")
    @railsver = `rails -v`.gsub("\n","")
    @railsenv = `echo $RAILS_ENV`
    @sidekiqstat = `ps -ef | grep sidekiq|grep -v grep|awk '{print $8" "$9" "$10" "$11" "$12" "$13" "$14}'`
    @sidekiqpex = `ps -ef | grep sidekiq|grep -v grep`
    @sidekiqex = $?.exitstatus
  end
  
  def create_deployment(application, build, env_id)
    @app = Application.find_by_name(application)
    @roles = @app.appropriate_roles.uniq
    @plan = DeploymentPlan.find_by_application_id(@app.id) || DeploymentPlan.find(1)
    @success_msg = ""
    @roles.each do |r|
      @d = Deployment.create(:application_id => @app.id, :build_number => build, :environment_id => env_id, :role_id => r.id, :mail_recipient_id => @plan.mail_recipient_id, :run_pre_checkout => true, :run_post_checkout => true, :skip_diskspace_check => false, :auto_accept => true, :auto_start => true)
      @success_msg << "Deployment #{@d.full_name} created" 
    end

    @success_msg << "  Rerun the esr to see the results."
  end
end
