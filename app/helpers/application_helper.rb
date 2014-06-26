module ApplicationHelper
  def log_formatter(event)
    out = ""
    event.run_logs.sort_by(&:created_at).reverse.each do |l|
      out << "<strong>" << l.created_at.to_s(:pretty) << "</strong>"
      out << "<br /><tt>"
      out << l.log if l.log
      out << "</tt><br />"
    end
    out.html_safe
  end

  def reject_reason_form(obj)
#    form_for obj do |f|
#      f.text_field obj.rejection_reason
#      f.submit "Submit"
#    end
  end

  def deployable_environment(e)
    @config.deployable_environments.include?(e)
  end
end
