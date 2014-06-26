class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  protect_from_forgery
  helper_method :admin?, :current_user_is_me?, 
                :manages_users?, :manages_database?, :manages_system?, :manages_threads?,
                :creates_deployments?, :creates_switches?, :approves?, :setup_incomplete?,
                :executes_deployments?, :executes_switches?, :views_reports?, :creates_reports?,
                :refreshes_tripcase?, :stratus_quote

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :setup
  after_filter :teardown

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  def stratus_quote
    random_bin[rand(random_bin.size)]
  end
 
  def basic_setup
    @config = SystemConfiguration.in_effect
    @start_datetime = Time.now
    @rubyver = `ruby -v`.gsub("\n","")
    @railsver = `rails -v`.gsub("\n","")
    @railsenv = `echo $RAILS_ENV`
    @sidekiqstat = `ps -ef | grep sidekiq|grep -v grep|awk '{print $8" "$9" "$10" "$11" "$12" "$13" "$14}'`
    @sidekiqpex = `ps -ef | grep sidekiq|grep -v grep`
    @sidekiqex = $?.exitstatus
    @useful_links = UsefulLink.all.sort_by(&:name)
    @latest_releases = LatestRelease.latest_batch if @config.show_latest_releases?
    if @config.show_latest_webapp?
      if @config.latest_webapp_at.blank? || ((@config.latest_webapp_at - Time.now) > 900) 
        SystemConfiguration.delay.get_latest_webapp
      else
        @latest_webapp = @config.latest_webapp 
      end
    end
  end
  
private
  def setup
    @config = SystemConfiguration.in_effect
    @start_datetime = Time.now
    @rubyver = `ruby -v`.gsub("\n","")
    @railsver = `rails -v`.gsub("\n","")
    @railsenv = `echo $RAILS_ENV`
    @sidekiqstat = `ps -ef | grep sidekiq|grep -v grep|grep -v tail|awk '{print $8" "$9" "$10" "$11" "$12" "$13" "$14}'`
    @sidekiqpex = `ps -ef | grep sidekiq|grep -v grep|grep -v tail`
    @sidekiqex = $?.exitstatus
    @useful_links = UsefulLink.all.sort_by(&:name)
    @latest_releases = LatestRelease.latest_batch
  end

  def render_error(status, exception)
    respond_to do |format|
      @config = SystemConfiguration.in_effect
      @start_datetime = Time.now
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end

  def teardown
  end

  def admin?
    current_user.admin? 
  end

  def setup_incomplete?
    current_user.setup_incomplete?
  end

  def approves?
    current_user.approves?
  end

  def manages_users?
    current_user.manages_users? 
  end

  def manages_database?
    current_user.manages_database? 
  end

  def manages_system?
    current_user.manages_system? 
  end

  def manages_threads?
    current_user.manages_threads? 
  end

  def creates_deployments?
    current_user.creates_deployments? 
  end

  def refreshes_tripcase?
    current_user.refreshes_tripcase?
  end

  def creates_switches?
    current_user.creates_switches? 
  end

  def executes_deployments?
    current_user.executes_deployments? 
  end

  def executes_switches?
    current_user.executes_switches? 
  end

  def creates_reports?
    current_user.creates_reports?
  end

  def views_reports?
    current_user.views_reports?
  end

  def current_user_is_me?
    current_user.email == "jason.michael@travelocity.com" 
  end

  def random_bin
    [
     "Stratus was built in 15 minutes.", 
     "Stratus is 97% pure.  And blue!",
     "Stratus was built by 15 minute developers.  Short people got no reason...", 
     "Stratus was built in many 15 minute fits of hilarity.", 
     "Stratus was built in many 15 minute chunks.",
     "Stratus.  15 minutes.  Enough said.",
     "If it looks like it was built in 15 minutes, it's probably Stratus.",
     "Somebody said 'Stratus!' and 15 minutes later, there was rejoicing.", 
     "Stratus is 15 minutes away from incarceration.",
     "Perry Mason could defend Stratus in 15 minutes.",
     "Stratus can swallow a jar full of pickled eggs in 15 minutes.",
     "Stratus is the best 15 minutes of your life.",
     "Stratus was built by 15 angry dwarves fighting over a chicken bone.",
     "Stratus means clouds, get it?",
     "If the cloud is green, then it's not a Stratus cloud.",
     "You can't spell 'cloud' without Stratus.",
     "With Stratus, everybody wins.",
     "Everytime someone uses Stratus, an angel gets it's wings."
    ]
  end
end
