class ApplicationSyncJobsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def start
    if @application_sync_job
      @application_sync_job.update_attribute(:started_by, current_user.id)
      @application_sync_job.update_attribute(:started_at, Time.now)
      @application_sync_job.start!
    end
  end

  def create
    @application_sync_job = ApplicationSyncJob.new(params[:application_sync_job])
    if @application_sync_job.save
      flash[:notice] = "Successfully created Application Sync Job."
      start
      redirect_to @application_sync_job
    else
      render :action => 'new'
    end
  end

private
  def setup
    @start_datetime = Time.now
    @application_sync_job = ApplicationSyncJob.find(params[:id]) if params[:id]
    @current_jobs = ApplicationSyncJob.inflight
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
end
