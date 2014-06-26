module EnvironmentSyncReportsHelper

  def esr_action_buttons(r, esr)
    out = ""
    case r.conflict
      when "belongs to target but not trusted"
      when "belongs to trusted but not target"
      when "trusted version is higher" 
        btn_msg = "#{esr.trusted_environment_name} <i class='icon-arrow-right'></i> #{esr.target_environment_name}"
        if deployable_environment(esr.target_environment)
          out << link_to(correct_environment_sync_report_path(:application => r.package_name, :trust_version => r.trusted_version, :target_version => r.target_version, :trust_env_id => esr.trusted_environment.id, :target_env_id => esr.target_environment_id, :do => "deploy trust to target"), :class => 'btn btn-mini btn-success') do
                 btn_msg
                 end
        end
      when "target version is higher"
        btn_msg = "#{esr.target_environment_name} <i class='icon-arrow-right'></i> #{esr.trusted_environment_name}"
        if deployable_environment(esr.trusted_environment)
          out << link_to(correct_environment_sync_report_path(:application => r.package_name, :trust_version => r.trusted_version, :target_version => r.target_version, :trust_env_id => esr.trusted_environment.id, :target_env_id => esr.target_environment_id, :do => "deploy trust to target"), :class => 'btn btn-mini btn-success') do
                 btn_msg
                 end
        end
      end
    out.html_safe
  end

  def environment_sync_report_buttons(r)
    out = ""
    out << link_to("start!", start_environment_sync_report_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.startable? && creates_reports?
    out << link_to("rerun!", rerun_environment_sync_report_path(:id => r.id), :class => 'btn btn-mini btn-success') if r.rerunable? && creates_reports?
    out.html_safe
  end

  def environment_sync_report_state(r)
    states = {"new" => "badge",
              "capture_artifacts" => "badge",
              "do_comparisons" => "badge badge-warning",
              "assemble_results" => "badge badge-warning",
              "complete" => "badge badge-info"}
    out = ""

    out << "current state: "
    out << "<i class='icon-repeat'></i> " if r.in_retry?
    out << "<span class='#{states[r.current_state.to_s]}'>" unless r.current_state.blank?
    out << "#{r.current_state.to_s.humanize}" unless r.current_state.blank?
    out << "</span>" unless r.current_state.blank?
    out.html_safe
  end

  def environment_sync_report_state_bar(r)
    states = {"new" => "badge",
              "capture_artifacts" => "badge",
              "do_comparisons" => "badge badge-warning",
              "assemble_results" => "badge badge-warning",
              "complete" => "badge badge-info"}
    out = ""

    curr_badge = "badge badge-inverse"
    states.each_key do |s|
      if r.current_state.to_s == s
        out << "<span class='#{states[r.current_state.to_s]}'>" unless r.current_state.blank?
        out << "<i class='icon-repeat'></i> " if r.in_retry?
        out << "#{r.current_state.to_s.humanize}" unless r.current_state.blank?
        out << "</span>" unless r.current_state.blank?
        curr_badge = "badge"
      else
        out << "<span class='#{curr_badge}'>"
        out << '.' 
        out << "</span>"
      end
    end
    out.html_safe
  end
end
