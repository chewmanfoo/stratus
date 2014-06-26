class ReloadRequestsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup
  def accept
    if @reload_request
      @reload_request.accepted_by = request.remote_ip 
      @reload_request.accepted_at = Time.now
      if @reload_request.save
        flash[:notice] = "You have successfully accepted this Reload Request."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with accepting this Reload Request!"
        redirect_to reload_requests_path
      end
    else
      flash[:error] = "That Reload Request was not found.  Check your work!"
      redirect_to reload_requests_path
    end
  end

  def complete
    if @reload_request
      @reload_request.completed_by = request.remote_ip 
      @reload_request.completed_at = Time.now
      if @reload_request.save
        flash[:notice] = "You have successfully completed this Reload Request."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with completing this Reload Request!"
        redirect_to reload_requests_path
      end
    else
      flash[:error] = "That Reload Request was not found.  Check your work!"
      redirect_to reload_requests_path
    end
  end

  def reject 
    if @reload_request
      @reload_request.rejected_by = request.remote_ip 
      @reload_request.rejected_at = Time.now
      if @reload_request.save
        flash[:notice] = "You have successfully rejected this Reload Request."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with rejecting this Reload Request!"
        redirect_to reload_requests_path
      end
    else
      flash[:error] = "That Reload Request was not found.  Check your work!"
      redirect_to reload_requests_path
    end
  end

private
  def setup
    @start_datetime = Time.now
#    @reload_requests = ReloadRequest.all.sort_by(&:created_at)
    @roles = Role.all.sort_by(&:name)
    @environments = Environment.all.sort_by(&:name)
    @reload_request = ReloadRequest.find(params[:id]) if params[:id]
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
