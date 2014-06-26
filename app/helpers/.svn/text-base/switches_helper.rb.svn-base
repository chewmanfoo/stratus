module SwitchesHelper

  def switch_details(r)
    out = '<ul class="switch_details">'
    out << '<li><b>Environment: </b>'
    out << "#{r.environment.name if r.environment}</li>"
    out << '<li><b>Role: </b>' 
    out << "#{r.role.name if r.role}</li>"
    out << '</ul>'
    out.html_safe
  end

  def switch_buttons(r)
    out = ""
    out << link_to("complete!", complete_switch_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.completable?
    out << link_to("start!", start_switch_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.startable? && executes_switches?
    out << link_to("accept!", accept_switch_path(:id => r.id), :class => 'btn btn-mini btn-primary', :rel => "popover", :data => {:content => "accepts this Switch Deployment into your workload", :title => "What is this?", :trigger => "hover"}) << " or" if r.acceptable?
    out << link_to("reject!", reject_switch_path(:id => r.id), :class => 'btn btn-mini btn-warning reject', :data => {:content => reject_switch_path(:id => r.id), :title => "Rejection reason"}) if r.rejectable? && admin?
    out.html_safe
  end

  def switch_status(r)
    out = ""
    out << "rejected at #{r.rejected_at.to_s(:pretty)}<br />" if r.rejected
    out << "accepted at #{r.accepted_at.to_s(:pretty)}<br />" if r.accepted
    out << "started at #{r.started_at.to_s(:pretty)} <strong>by</strong> #{mail_to r.starter_email, r.starter_given_name}<br />" if r.started
    out << "completed at #{r.completed_at.to_s(:pretty)}<br />" if r.completed
    out << link_to("complete!", complete_switch_path(:id => r.id), :class => 'btn btn-mini btn-success', :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Complete informs everyone that the Switch Deployment is verified complete.  Are you sure?')) }) if r.completable?
    out << link_to("start!", start_switch_path(:id => r.id), :class => 'btn btn-mini btn-success', :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Start executes the Switch Deployment.  Are you sure?')) }) if r.startable? && executes_switches?
    out << link_to("accept!", accept_switch_path(:id => r.id), :class => 'btn btn-mini btn-primary', :rel => "popover", :data => {:content => "accepts this Switch Deployment into your workload", :title => "What is this?", :trigger => "hover"}) << " or" if r.acceptable?
    out << link_to("reject!", reject_switch_path(:id => r.id), :class => 'btn btn-mini btn-warning reject', :data => {:content => reject_switch_path(:id => r.id), :title => "Rejection reason"}) if r.rejectable?
    out.html_safe
  end

  def switch_state(r)
    states = {"new" => "badge",
              "ready" => "badge badge-success",
              "started" => "badge badge-warning",
              "check_cobbler" => "badge badge-warning",
              "subversion_file" => "badge badge-warning",
              "syncmanifest" => "badge badge-warning",
              "deploy" => "badge badge-warning",
              "check_deployment" => "badge badge-warning",
              "complete_review" => "badge badge-info",
              "fail_review" => "badge badge-important",
              "execution_complete" => "badge badge-info",
              "complete" => "badge badge-inverse"}
    out = ""

    out << "current state: "
    out << "<i class='icon-repeat'></i> " if r.in_retry?
    out << "<span class='#{states[r.current_state.to_s]}'>" unless r.current_state.blank?
    out << "#{r.current_state.to_s.humanize}" unless r.current_state.blank?
    out << "</span>" unless r.current_state.blank?
    out.html_safe
  end

end
