class SearcherController < ApplicationController
  before_filter :setup

  def index
    @applications = Application.search(params[:search]) 
    @servers = Server.search(params[:search])
    @environments = Environment.search(params[:search])
    @roles = Role.search(params[:search])
    @deployments = Deployment.search(params[:search])
    @switches = Switch.search(params[:search])
    @users = User.search(params[:search])
  end

private
  def setup
    @start_datetime = Time.now
    @application_sync_job = ApplicationSyncJob.find(params[:id]) if params[:id]
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
