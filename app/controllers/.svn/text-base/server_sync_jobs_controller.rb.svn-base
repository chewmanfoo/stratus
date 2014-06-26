class ServerSyncJobsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def start
    if @server_sync_job
      @server_sync_job.update_attribute(:started_by, current_user.id)
      @server_sync_job.update_attribute(:started_at, Time.now)
      @server_sync_job.start!
    end
  end

  def create
    @server_sync_job = ServerSyncJob.new(params[:server_sync_job])
    if @server_sync_job.save
      flash[:notice] = "Successfully created Server Sync Job."
      start
      redirect_to @server_sync_job
    else
      render :action => 'new'
    end
  end

private
  def setup
    @start_datetime = Time.now
    @server_sync_job = ServerSyncJob.find(params[:id]) if params[:id]
    @current_jobs = ServerSyncJob.inflight
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
