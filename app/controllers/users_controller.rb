class UsersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def edit
    @user = User.find(params[:id])
    unless admin?
      unless current_user == @user
        flash[:error] = "You can only edit yourself!"
        redirect_to root_url
      end
    end
  end

  def refresh_token
    @user = User.find(params[:id])
    if @user.ensure_authentication_token!
      flash[:notice] = "Authentication Token has been created."
      redirect_to root_url
    else
      flash[:error] = "Could not refresh Authentication Token!"
      redirect_to root_url
    end
  end

  def show
    @user = User.find(params[:id])
    @deployments = Deployment.by_user(current_user.id)
    @switches = Switch.by_user(current_user.id)
    @refreshes = Refresh.by_user(current_user.id)
  end

private
  def setup
#    @deployments = Deployment.by_user(params[:id]) if params[:id]
#    @switches = Switch.by_user(params[:id]) if params[:id]
    @start_datetime = Time.now
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
