module RefreshesHelper

  def refresh_details(r)
    out = '<ul class="refresh_details">'
    out << '<li><b>Environment: </b>'
    out << "#{r.environment.name if r.environment}</li>"
    out << '<li><b>Role: </b>' 
    out << "#{r.role.name if r.role}</li>"
    out << '</ul>'
    out.html_safe
  end

  def refresh_servers_links(s)
    out = ""
    s.each do |i|
      out << link_to(i.short_name, i, :class => "btn btn-mini btn-default")
    end
    out.html_safe
  end

  def refresh_status(r)
    out = ""
#    out << "<strong>started at</strong> #{r.started_at.to_s(:pretty)} <strong>by</strong> #{mail_to r.starter_email, r.starter_given_name}<br />" if r.started
#    out << "<strong>completed at</strong> #{r.completed_at.to_s(:pretty)} <strong>by</strong> #{mail_to r.completor_email, r.completor_given_name}<br />" if r.completed
    out << link_to("complete!", complete_refresh_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.completable?
    out.html_safe
  end

  def refresh_buttons(r)
    out = ""
    out << link_to("terminate!", terminate_refresh_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.terminatable?
    out << link_to("complete!", complete_refresh_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.completable?
    out << link_to("fail!", complete_refresh_path(:id => r.id), :class => 'btn btn-mini btn-inverse') if r.failable?
    out.html_safe
  end

  def refresh_states
    {"new" => "badge",
     "syncmanifest" => "badge badge-info",
     "deploy" => "badge badge-primary",
     "complete" => "badge badge-success",
     "fail" => "badge badge-danger",
     "finished" => "badge badge-inverse"}
  end

  def refresh_states_explanation
    {"new" => "Refresh has been created but has not begun pre-flight check.",
     "syncmanifest" => "Refresh is syncing puppet on the target Environment.  This may take up to 5 minutes.",
     "deploy" => "Refresh is instructing puppet to refresh.  This should cause new manifests to be applied.  This may take up to 10 minutes.",
     "complete" => "Refresh is complete.",
     "fail" => "Refresh has failed.",
     "finished" => "Refresh has finished execution."}
  end

  def refresh_state(r)
    out = ""

    out << "current state: "
    out << "<i class='icon-repeat'></i> " if r.in_retry?
    out << "<span class='#{refresh_states[r.current_state.to_s]}' rel='popover' data-content='popover content' data-title='popover title' data-trigger='hover'>" unless r.current_state.blank?
    out << "#{r.current_state.to_s.humanize}" unless r.current_state.blank?
    out << "</span>" unless r.current_state.blank?
    out.html_safe
  end

  def refresh_state_bar(r)
    out = ""

    curr_badge = "badge badge-inverse"
    refresh_states.each_key do |s|
      if r.current_state.to_s == s
        out << "<a href='#' class='#{refresh_states[r.current_state.to_s]}' rel='popover' data-html='true' data-placement='right' data-content='#{refresh_popover_content(r,s)}' data-title='#{refresh_popover_title(r,s)}' data-trigger='hover'>" unless r.current_state.blank?
        out << "<i class='icon-repeat'></i> " if r.in_retry?
        out << "#{r.current_state.to_s.humanize}" unless r.current_state.blank?
        out << "</a>" unless r.current_state.blank?
        curr_badge = "badge"
      else
        out << "<a href='#' class='#{curr_badge}' rel='popover' data-html='true' data-placement='right' data-content='#{refresh_popover_content(r,s)}' data-title='#{refresh_popover_title(r,s)}' data-trigger='hover'>"
        out << '.' 
        out << "</a>"
      end
    end
    out.html_safe
  end

  def refresh_popover_title(d,s)
    "<b>#{s}</b>"
  end

  def refresh_popover_content(d,s)
    out = ""
    out << "<i>#{refresh_states_explanation[s.to_s]}</i><br />"
#    @timings = DeploymentTiming.by_refresh_id_by_state(d.id,s)
#    @timings.each do |t|
#      out << "<b>#{t.event}</b>: #{t.created_at.to_s(:pretty)}<br />"
#    end
    out.html_safe
  end

  def refresh_popover_summary(d,s)
    out = ""
    out << "total runtime: #{d.total_time_seconds} seconds"
    out.html_safe
  end

  def refresh_form_actions(d)
    out = ""
      out << "#{link_to t('.back', :default => t('helpers.links.back')), refreshes_path, :class => 'btn'}"    
      out << "#{link_to t('.destroy', :default => t('helpers.links.destroy')), refresh_path(d), :method => 'delete', :data => { :confirm => t('.confirm', :default => t('helpers.links.confirm', :default => 'Are you sure?')) },:class => 'btn btn-danger', :rel => 'popover', 'data-content' => 'deletes a Refresh from the database', 'data-title' => '<b>Delete a Refresh</b>', 'data-html' => 'true', 'data-trigger' => 'hover'}" if current_user_is_me? || d.destroyable?
      out << "#{link_to 'complete!', complete_refresh_path(:id => d.id), :class => 'btn btn-success'}" if d.completable?
      out << "#{link_to 'terminate!', terminate_refresh_path(:id => d.id), :class => 'btn btn-danger'}" if d.terminatable?
    out.html_safe
  end
end
