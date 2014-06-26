module FlowsHelper

  def flow_parts_bubbles(f)
    out = ""
    f.flow_parts_by_name_id.each do |n,i|
      p = FlowPart.find(i)
      out << "<a href='#{flow_part_path(p)}' class='badge badge-success' rel='popover' data-html='true' data-placement='right' data-content='#{p.chore_command}' data-title='#{p.chore_name}' data-trigger='hover'>" unless p.blank?
      out << "#{p.name}" unless p.name.blank?
      out << "</a>" unless p.name.blank?
    end
    out.html_safe
  end

end
