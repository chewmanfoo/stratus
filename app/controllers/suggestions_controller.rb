class SuggestionsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

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
end
