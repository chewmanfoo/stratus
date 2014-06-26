class AuthKeysController < InheritedResources::Base
  before_filter :setup
  before_filter :authenticate_user!

  def create
    @auth_key = AuthKey.new(params[:auth_key])
    @auth_key.creator = current_user

    respond_to do |format|
      if @auth_key.save
        format.html { redirect_to(@auth_key, :notice => 'Auth Key was successfully created.') }
        format.json { render :json => @auth_key, :status => :created, :location => @auth_key }
      else
        format.html { render :action => "new" }
        format.json { render :json => @auth_key.errors, :status => :unprocessable_entity }
      end
    end
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
end
