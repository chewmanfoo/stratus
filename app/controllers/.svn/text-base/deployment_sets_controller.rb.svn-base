class DeploymentSetsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :setup

  def create
    success_msg = ""

    @deployment_set = current_user.created_deployment_sets.build(params[:deployment_set])
    if @deployment_set.save
      @deployment_set.environments.each do |e|
        @deployment_set.roles.each do |r|
          d = current_user.created_deployments.build(:application_id => @deployment_set.application_id,
                                :build_number => @deployment_set.build_number,
                                :run_pre_checkout => @deployment_set.run_pre_checkout,
                                :run_post_checkout => @deployment_set.run_post_checkout,
                                :auto_accept => @deployment_set.auto_accept,
                                :auto_start => @deployment_set.auto_start,
                                :mail_recipient_id => @deployment_set.mail_recipient_id,
                                :changelist => @deployment_set.changelist,
                                :deployment_set_id => @deployment_set.id,
                                :environment_id => e.id,
                                :role_id => r.id)
          if d.save
            s = DeploymentWorkflowEngine.new(d.id, @config.id)
            if s.create(current_user)
              success_msg << "Deployment #{d.name} created. "
            end
          else
          end
        end
      end

      flash[:notice] = success_msg         
      redirect_to root_url
    else
      flash[:error] = "There was a problem saving this Deployment Set!"
      redirect_to root_url
    end
  end
private
  def setup
    @start_datetime = Time.now
#    @applications = Application.find(:all, :select => 'name, id')
    @applications = Application.sorted_by_name
    @roles = Role.sorted_by_name
    @environments = Environment.sorted_by_name
    @mail_recipients = MailRecipient.sorted_by_name
    @deployment_set = DeploymentSet.find(params[:id]) if params[:id]
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
