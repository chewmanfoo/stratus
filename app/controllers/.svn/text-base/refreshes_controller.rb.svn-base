class RefreshesController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def complete
    @refresh = Refresh.find(params[:id])
    if @refresh
      e = RefreshWorkflowEngine.new(@refresh.id, @config.id)
      if e.complete(current_user)
        flash[:notice] = "You have successfully completed this Refresh."
          redirect_to root_url
        else
          flash[:error] = "There was a problem with completing this Refresh!"
          redirect_to refreshes_path
        end
    else
      flash[:error] = "That Refresh was not found.  Check your work!"
      redirect_to refreshes_path
    end
  end

  def create
    @refresh = current_user.created_refreshes.create(params[:refresh])

    if @refresh.save
      e = RefreshWorkflowEngine.new(@refresh.id, @config.id)

      respond_to do |format|
        if e.create(current_user)
#          format.html { redirect_to(@refresh, :notice => "Refresh was successfully created.") }
          format.html { redirect_to(root_url, :notice => "Refresh was successfully created.") }
          format.json { render :json => @refresh, :status => :created, :location => @refresh }
        else
          format.html { render :action => "new" }
          format.json { render :json => @refresh.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def new 
    @refresh = build_resource
    @roles = Role.tcs.sorted_by_name
    @environments = Environment.tcs.sorted_by_name
    new!
  end

  def index
    @refreshes = Refresh.paginate(:page => params[:page], :per_page => 7, :order => "created_at DESC")
    @incomplete_refreshes = Refresh.incomplete

    respond_to do |f|
      f.html
      f.json
      f.xml
    end
  end

  def show
#    @use_help_mailer = true unless @refresh.devsvcs_help_email_sent?
    @refresh = Refresh.find(params[:id])
    if @refresh
      respond_to do |f|
        f.html
        f.json
        f.xml
      end
    else
      flash[:error] = "Could not find that Refresh!"
      redirect_to root_url
    end
  end

  def terminate
    @refresh = Refresh.find(params[:id])
    if @refresh
      e = RefreshWorkflowEngine.new(@refresh.id, @config.id)

      unless @refresh.finished?
        if e.terminate(current_user)
          flash[:notice] = "You have successfully terminated this Refresh."
          redirect_to root_url
        else
          flash[:error] = "There was a problem with terminating this Refresh!"
          redirect_to refreshes_path
        end
      else
        redirect_to(@refresh, :error => "Refresh can't be terminated.")
      end
    else
      flash[:error] = "That Refresh was not found.  Check your work!"
      redirect_to refreshes_path
    end
  end

  def destroy
    @refresh = Refresh.find(params[:id])
    @refresh.destroy
    flash[:success] = "Refresh destroyed."
    redirect_to root_url
  end

private
  def setup
    @start_datetime = Time.now
    @config = SystemConfiguration.in_effect
    @useful_links = UsefulLink.sorted_by_name
    @latest_releases = LatestRelease.latest_batch
    @rubyver = `ruby -v`.gsub("\n","")
    @railsver = `rails -v`.gsub("\n","")
    @railsenv = `echo $RAILS_ENV`
    @sidekiqstat = `ps -ef | grep sidekiq|grep -v grep|awk '{print $8" "$9" "$10" "$11" "$12" "$13" "$14}'`
    @sidekiqpex = `ps -ef | grep sidekiq|grep -v grep`
    @sidekiqex = $?.exitstatus
  end

protected
  def resource
    @refresh = build_resource
    if admin?
      @roles = Role.sorted_by_name
      @environments = Environment.sorted_by_name
    else
      @roles = Role.tcs.sorted_by_name
      @environments = Environment.tcs.sorted_by_name
    end
  end
end
