module SyncJobsHelper
  def sync_job_state_bar(r)
    states = {"new" => "badge",
              "running" => "badge badge-warning",
              "complete" => "badge badge-inverse"}
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
