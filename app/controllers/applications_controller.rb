class ApplicationsController < InheritedResources::Base
  require 'csv'

  before_filter :authenticate_user!, :setup

  def index
    @applications = Application.order(:name)
    @config = SystemConfiguration.in_effect
    @useful_links = UsefulLink.all.sort_by(&:name)
    @latest_releases = LatestRelease.latest_batch
    respond_to do |format|
      format.html { @applications = Application.paginate(:page => params[:page], :per_page => 20) }
      format.csv
      format.json { render json: @applications.where("name like ?", "%#{params[:q]}%") }
    end
  end

private
  def setup
    @application = Application.find(params[:id]) if params[:id]
    @start_datetime = Time.now
#    @deployments = Deployment.all.sort_by(&:created_at)
    @deployment_plan = @application.deployment_plan if @application
    @applications = Application.find(:all, :select => 'name, id')
    @roles = Role.all.sort_by(&:name)
    @environments = Environment.all.sort_by(&:name)
    @mail_recipients = MailRecipient.all.sort_by(&:name)
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
