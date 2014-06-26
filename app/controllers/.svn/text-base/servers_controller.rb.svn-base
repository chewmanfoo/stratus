class ServersController < InheritedResources::Base
  require 'csv'

  before_filter :authenticate_user!
  before_filter :setup

  def index
    @servers = Server.all
    respond_to do |format|
      format.html { @servers = Server.paginate(:page => params[:page], :per_page => 20) }
      format.csv
    end
  end

  def clear_logs
    switch = "tvl-service-tomcat-remove-logs"
    build = "2000"
    @switch = new_switch(switch, build, params[:environment_id], params[:role_id])
    flash[:notice] = "#{@switch.name} successfully created!"
    redirect_to @switch
  end

  def restart_tomcat
    switch = "tvl-service-tomcat-restart"
    build = "1988"
    @switch = new_switch(switch, build, params[:environment_id], params[:role_id])
    flash[:notice] = "#{@switch.name} successfully created!"
    redirect_to @switch
  end

private
  def setup
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

  def new_switch(sw, build, e, r)
    mail_recipient_id = current_user.default_mail_recipient.id 
    @s = Switch.create(:name => sw, :build_number => build, :environment_id => e.to_i, :role_id => r.to_i, :mail_recipient_id => mail_recipient_id)
    if @s.save
      @s.accept
      @s.start
    end
    @s
  end
end
