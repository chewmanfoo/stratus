module DeploymentsHelper

  def checkout_formatter(co)
    if /Sanity/.match(co)
      out = '<table class="table table-bordered">'
      co.gsub(/[\n\r]/,"").gsub("0 / 11 / 1","").gsub("\e\[31m","").gsub("\e\[0m","").chop.split(',').each_slice(2) do |i,j|
        out << "<tr><td>#{i}</td>"
        out << "<td>#{j}</td></tr>"
      end
      out << '</table>'
      out.html_safe
    end
  end

  def deployment_details(r)
    out = '<ul class="deployment_details">'
    out << '<li><b>Environment: </b>'
    out << "#{r.environment.name if r.environment}</li>"
    out << '<li><b>Role: </b>' 
    out << "#{r.role.name if r.role}</li>"
    out << '</ul>'
    out.html_safe
  end

  def deployment_servers_links(s)
    out = ""
    s.each do |i|
      out << link_to(i.short_name, i, :class => "btn btn-mini btn-default")
    end
    out.html_safe
  end

  def deployment_status(r)
    out = ""
    if r.approved && r.approval_needed?
      out << "<strong>approved by</strong> #{r.approver_given_name} at #{r.approved_at.to_s(:pretty) if r.approved_at}<br />" 
    else
      out << "unapproved<br />" if r.approval_needed?
      out << "approval not required<br />" if ! r.approval_needed?
    end
    out << "<strong>rejected at</strong> #{r.rejected_at.to_s(:pretty)} <strong>by</strong> #{mail_to r.rejector_email, r.rejector_given_name}<br />" if r.rejected
    out << "<strong>accepted at</strong> #{r.accepted_at.to_s(:pretty)} <strong>by</strong> #{mail_to r.acceptor_email, r.acceptor_given_name}<br />" if r.accepted
    out << "<strong>started at</strong> #{r.started_at.to_s(:pretty)} <strong>by</strong> #{mail_to r.starter_email, r.starter_given_name}<br />" if r.started
    out << "<strong>completed at</strong> #{r.completed_at.to_s(:pretty)} <strong>by</strong> #{mail_to r.completor_email, r.completor_given_name}<br />" if r.completed
    out << link_to("complete!", complete_deployment_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.completable?
    out << link_to("roll back!", rollback_deployment_path(:id => r.id), :class => 'btn btn-mini btn-warning') if r.rollbackable?
    out << link_to("fail!", complete_deployment_path(:id => r.id), :class => 'btn btn-mini btn-inverse') if r.failable?
    out << link_to("start!", start_deployment_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.startable? && executes_deployments?
    out << link_to("accept!", accept_deployment_path(:id => r.id), :class => 'btn btn-mini btn-primary') if r.acceptable?
    out << " or " + link_to("reject!", reject_deployment_path(:id => r.id), :class => 'btn btn-mini btn-warning reject') if r.rejectable?
    out << link_to("approve!", approve_deployment_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.approval_needed? && approves?
    out.html_safe
  end

  def deployment_buttons(r)
    out = ""
    out << link_to("complete!", complete_deployment_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.completable?
    out << link_to("roll back!", rollback_deployment_path(:id => r.id), :class => 'btn btn-mini btn-warning') if r.rollbackable?
    out << link_to("fail!", complete_deployment_path(:id => r.id), :class => 'btn btn-mini btn-inverse') if r.failable?
    out << link_to("start!", start_deployment_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.startable? && executes_deployments?
    out << link_to("accept!", accept_deployment_path(:id => r.id), :class => 'btn btn-mini btn-primary') if r.acceptable?
    out << " or " + link_to("reject!", reject_deployment_path(:id => r.id), :class => 'btn btn-mini btn-warning reject') if r.rejectable?
    out << link_to("approve!", approve_deployment_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.approval_needed? && approves? 
    out.html_safe
  end

  def states
    {"new" => "badge",
     "awaiting_approval" => "badge",
     "awaiting_acceptance" => "badge",
     "approved" => "badge badge-success",
     "started" => "badge badge-warning",
     "check_concurrent_deployment" => "badge badge-inverse",
     "check_cobbler" => "badge badge-warning",
     "check_disc_space" => "badge badge-warning",
     "capture_rollback_version" => "badge badge-warning",
     "subversion_file" => "badge badge-warning",
     "syncmanifest" => "badge badge-warning",
     "go_oos" => "badge badge-important",
     "check_oos" => "badge badge-important",
     "bleedoff" => "badge badge-warning",
     "deploy" => "badge badge-warning",
     "redeploy" => "badge badge-warning",
     "check_deployment" => "badge badge-warning",
     "go_is" => "badge badge-important",
     "check_is" => "badge badge-important",
     "complete_review" => "badge badge-info",
     "fail_review" => "badge badge-important",
     "execution_complete" => "badge badge-info",
     "complete" => "badge badge-inverse"}
  end

  def states_explanation
    {"new" => "Deployment has been created but has not begun pre-flight check.",
     "awaiting_approval" => "Deployment is waiting for approval from Release Management. Environments which require approval are defined in the System Configuration. You can ensure automatic approval by signing off Deployment application/build number for <b>Functional</b> in REO.",
     "awaiting_acceptance" => "Deployment is waiting for an agent to accept into workload.",
     "approved" => "Deployment is approved for execution in environment.",
     "started" => "Deployment has completed pre-flight check and has begin execution.",
     "check_concurrent_deployment" => "Deployment is verifying that there are no other Deployments of the same package to the same Environment of lesser build numbers.  These Deployments will be terminated.",
     "check_cobbler" => "Deployment is verifying that package/build number are in the repo.",
     "check_disc_space" => "Deployment is verifying that target servers had enough disc space on the root drive for deployment.",
     "capture_rollback_version" => "Deployment is recording the current build number of package for rollback if necessary.",
     "subversion_file" => "Deployment is modifying puppet configuration to upgrade the package on the target servers.",
     "syncmanifest" => "Deployment is syncing puppet on the target Environment.  This may take up to 5 minutes.",
     "go_oos" => "If global and Application level use_oos_for_deployments value is true, and Environment requires OOS (specified in DeploymentPlan), take instance Out of Service.",
     "check_oos" => "If global and Application level use_oos_for_deployments value is true, and Environment requires OOS (specified in DeploymentPlan), verify instance is Out of Service.",
     "bleedoff" => "Wait deployment_plan.bleedoff_seconds after the instances are out of service before proceeding with deployment.",
     "deploy" => "Deployment is instructing puppet to refresh.  This should cause the package to upgrade to the new build number.  This may take up to 10 minutes.",
     "redeploy" => "Apparently, the previous deployment failed.  Deployment is attempting to refresh puppet again.  This may take up to 10 minutes.",
     "check_deployment" => "Deployment is verifying that the package and build number is now installed on the target servers.",
     "go_is" => "If global and Application level use_oos_for_deployments value is true, and Environment requires OOS (specified in DeploymentPlan), take instance In Service.",
     "check_is" => "If global and Application level use_oos_for_deployments value is true, and Environment requires OOS (specified in DeploymentPlan), verify instance is In Service.",
     "complete_review" => "Deployment is complete.  Please review the Deployment log and click <b>complete</b> when done.",
     "fail_review" => "Deployment has failed.  Please review the Deployment log and click <b>fail</b> when done.",
     "execution_complete" => "Deployment is complete.",
     "complete" => "Deployment is complete."}
  end

  def deployment_state(r)
    out = ""

    out << "current state: "
    out << "<i class='icon-repeat'></i> " if r.in_retry?
    out << "<span class='#{states[r.current_state.to_s]}' rel='popover' data-content='popover content' data-title='popover title' data-trigger='hover'>" unless r.current_state.blank?
    out << "#{r.current_state.to_s.humanize}" unless r.current_state.blank?
    out << "</span>" unless r.current_state.blank?
    out.html_safe
  end

  def deployment_state_bar(r)
    out = ""

    curr_badge = "badge badge-inverse"
    states.each_key do |s|
      if r.current_state.to_s == s
        out << "<a href='#' class='#{states[r.current_state.to_s]}' rel='popover' data-html='true' data-placement='right' data-content='#{deployment_popover_content(r,s)}' data-title='#{deployment_popover_title(r,s)}' data-trigger='hover'>" unless r.current_state.blank?
        out << "<i class='icon-repeat'></i> " if r.in_retry?
        out << "#{r.current_state.to_s.humanize}" unless r.current_state.blank?
        out << "</a>" unless r.current_state.blank?
        curr_badge = "badge"
      else
        out << "<a href='#' class='#{curr_badge}' rel='popover' data-html='true' data-placement='right' data-content='#{deployment_popover_content(r,s)}' data-title='#{deployment_popover_title(r,s)}' data-trigger='hover'>"
        out << '.' 
        out << "</a>"
      end
    end
    out.html_safe
  end

  def deployment_popover_title(d,s)
    "<b>#{s}</b>"
  end

  def deployment_popover_content(d,s)
    out = ""
    out << "<i>#{states_explanation[s.to_s]}</i><br />"
    @timings = DeploymentTiming.by_deployment_id_by_state(d.id,s)
    @timings.each do |t|
      out << "<b>#{t.event}</b>: #{t.created_at.to_s(:pretty)}<br />"
    end
    out.html_safe
  end

  def deployment_popover_summary(d,s)
    out = ""
    out << "total runtime: #{d.total_time_seconds} seconds"
    out.html_safe
  end

  def deployment_form_actions(d)
    out = ""
      out << "#{link_to t('.back', :default => t('helpers.links.back')), deployments_path, :class => 'btn'}"    
      out << "#{link_to t('.clone', :default => t('helpers.links.clone')), clone_deployment_path(:id => d.id), :class => 'btn', :rel => 'popover', 'data-content' => 'creates a new Deployment identical to this one', 'data-title' => '<b>Clone a Deployment</b>', 'data-html' => 'true', 'data-trigger' => 'hover'}"
      out << "#{link_to t('.destroy', :default => t('helpers.links.destroy')), deployment_path(d), :method => 'delete', :data => { :confirm => t('.confirm', :default => t('helpers.links.confirm', :default => 'Are you sure?')) },:class => 'btn btn-danger', :rel => 'popover', 'data-content' => 'deletes a Deployment from the database', 'data-title' => '<b>Delete a Deployment</b>', 'data-html' => 'true', 'data-trigger' => 'hover'}" if current_user_is_me? || d.destroyable?
      out << "#{link_to 'complete!', complete_deployment_path(:id => d.id), :class => 'btn btn-success'}" if d.completable?
      out << "#{link_to 'roll back!', complete_deployment_path(:id => d.id), :class => 'btn btn-warning'}" if d.rollbackable?
      out << "#{link_to 'start!', start_deployment_path(:id => d.id), :class => 'btn btn-success'}" if d.startable?
      out << "#{link_to 'terminate!', terminate_deployment_path(:id => d.id), :class => 'btn btn-danger'}" if d.terminatable?
      out << "#{link_to 'accept!', accept_deployment_path(:id => d.id), :class => 'btn btn-primary', :rel => 'popover', 'data-content' => 'accepts this Deployment into your workload', 'data-title' => '<b>Accept a Deployment</b>', 'data-html' => 'true', 'data-trigger' => 'hover'}" if d.acceptable?
      out << "#{link_to 'reject!', reject_deployment_path(:id => d.id), :class => 'btn btn-warning', :rel => 'popover', 'data-content' => 'marks this Deployment as Rejected', 'data-title' => '<b>Reject a Deployment</b>', 'data-html' => 'true', 'data-trigger' => 'hover'}" if d.rejectable?
      out << "#{link_to 'approve!', approve_deployment_path(:id => d.id), :class => 'btn btn-success'}" if d.approval_needed? && approves?
    out.html_safe
  end
end
