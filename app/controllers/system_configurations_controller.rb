class SystemConfigurationsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

private
  def setup
    @config = SystemConfiguration.in_effect
    @useful_links = UsefulLink.all.sort_by(&:name)
    @start_datetime = Time.now
    @latest_releases = LatestRelease.latest_batch
    @active_auth_keys = AuthKey.active
    @rubyver = `ruby -v`.gsub("\n","")
    @railsver = `rails -v`.gsub("\n","")
    @railsenv = `echo $RAILS_ENV`
    @sidekiqstat = `ps -ef | grep sidekiq|grep -v grep|awk '{print $8" "$9" "$10" "$11" "$12" "$13" "$14}'`
    @sidekiqpex = `ps -ef | grep sidekiq|grep -v grep`
    @sidekiqex = $?.exitstatus
  end
end
