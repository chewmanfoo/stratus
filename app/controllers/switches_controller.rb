class SwitchesController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def send_email
    begin
      yield
    rescue Errno::ECONNREFUSED
      logger.info "can't connect to sendmail?"
    end if @config.send_emails?
  end

  def clone
    @new_switch = @switch.dup
    @switch = @new_switch
    render :action => "new"
  end

  def create
    @switch = Switch.new(params[:switch])
    @switch.creator = current_user

    respond_to do |format|
      if @switch.save
        send_email do 
          SwitchesMailer.delay.switch_created(@switch.mail_recipient, @switch)
        end
        Switch.log_result(@switch, "Switch created by #{current_user.given_name}")

        format.html { redirect_to(@switch, :notice => 'Switch was successfully created.') }
        format.json { render :json => @switch, :status => :created, :location => @switch }
      else
        format.html { render :action => "new" }
        format.json { render :json => @switch.errors, :status => :unprocessable_entity }
      end
    end
  end

  def multinew
    @switch = Switch.new
  end
 
  def multicreate
    @errors = ""
    @notices = ""
    if (params[:switch][:switch_names])
logger.info "got params[:switch][:switch_names]: #{params[:switch][:switch_names]}"
      @switch_names = params[:switch][:switch_names]
      @switch_names.split(',').each do |s|
        @switch = Switch.new(params[:switch])
        @switch.name = s
        @switch.deploy_to_first_server_only = true

# doesn't handle switch names with split by dashes, so turn-google-adwords-off won't work
#                                                   but turn_google_adwords_off works fine

        @switch.supercedes_name = s.split('_').include?('on') ? s.gsub('on','off') : s.gsub('off','on')
        @switch.supercedes_build_number = @switch.build_number
        if @switch.save
          send_email do 
            SwitchesMailer.delay.switch_created(@switch.mail_recipient, @switch)
          end
          Switch.log_result(@switch, "Switch created by #{current_user.given_name}")

          @notices << "Switch #{@switch.name} successfully created. "
        else
          @errors << "There were problems creating switch #{@switch.name}.  Could not continue.<br />"
        end
      end
    else
      @errors = "I don't see any switch names.  Check your work!"
    end
    redirect_to(root_url, :notice => @notices, :error => @errors)
  end

  def accept
    if @switch
      @switch.update_attribute(:accepted_by, current_user.id)
      @switch.update_attribute(:accepted_at, Time.now)
      @switch.accept!

      if @switch.save
        send_email do 
          SwitchesMailer.delay.switch_accepted(@switch.mail_recipient, @switch)
        end
        Switch.log_result(@switch, "Switch accepted by #{current_user.given_name}")

        flash[:notice] = "You have successfully accepted this Switch."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with accepting this Switch!"
        redirect_to switches_path
      end
    else
      flash[:error] = "That Switch was not found.  Check your work!"
      redirect_to switches_path
    end
  end

  def proceed
    if @switch
      @switch.complete!
# need to clean up retrys for this switch
      redirect_to @switch
    else
      flash[:error] = "That Switch was not found.  Check your work!"
      redirect_to switches_path
    end
  end


  def complete
    if @switch
      @switch.completed_by = request.remote_ip
      @switch.completed_at = Time.now
      if @switch.save
        Switch.log_result(@switch, "Switch completed by #{current_user.given_name}")
        send_email do 
          SwitchesMailer.delay.switch_completed(@switch.mail_recipient, @switch)
        end
#PuppetWorker.perform_async(@switch.id)

        flash[:notice] = "You have successfully completed this Switch."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with completing this Switch!"
        redirect_to switches_path
      end
    else
      flash[:error] = "That Switch was not found.  Check your work!"
      redirect_to switches_path
    end
  end

  def reject
    if @switch
      @switch.rejected_by = request.remote_ip
      @switch.rejected_at = Time.now
      if @switch.save
        send_email do 
          SwitchesMailer.delay.switch_rejected(@switch.mail_recipient, @switch)
        end
        Switch.log_result(@switch, "Switch rejected by #{current_user.given_name}")

        flash[:notice] = "You have successfully rejected this Switch."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with rejecting this Switch!"
        redirect_to switches_path
      end
    else
      flash[:error] = "That Switch was not found.  Check your work!"
      redirect_to switches_path
    end
  end

  def start
    if @switch
      @switch.update_attribute(:started_by, current_user.id)
      @switch.update_attribute(:started_at, Time.now)
      @switch.start!
      @switch.execute!

      if @switch.save
        Switch.log_result(@switch, "Switch started by #{current_user.given_name}")
        send_email do
          SwitchesMailer.delay.switch_started(@switch.mail_recipient, @switch)
        end
#        PuppetSwitchWorker.perform_async(@switch.id)

        flash[:notice] = "You have successfully started this Switch."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with starting this Switch!"
        redirect_to switches_path
      end
    else
      flash[:error] = "That Switch was not found.  Check your work!"
      redirect_to switches_path
    end
  end  

  def index
    @switches = Switch.paginate(:page => params[:page], :per_page => 7, :order => "created_at DESC")
  end

  # DELETE /switches/1
  # DELETE /switches/1.json
  def destroy
    @switch = Switch.find(params[:id])
    @switch.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

private
  def setup
    @start_datetime = Time.now
    @roles = Role.sorted_by_name
    @environments = Environment.sorted_by_name
    @mail_recipients = MailRecipient.sorted_by_name
    @switch = Switch.find(params[:id]) if params[:id]
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
end
