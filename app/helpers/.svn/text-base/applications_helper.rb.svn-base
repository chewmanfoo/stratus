module ApplicationsHelper

  def server_icon_and_name(server, size)
    out = ""
    case size
      when "tiny"
        if server.inactive?
          out << "<td>#{image_tag 'server-inactive.png', :width => "50px"}<br />#{server.name}</td>"
        else
          out << "<td>#{image_tag 'server.png', :width => "50px"}<br />#{server.name}</td>"
        end
      when "full"
        if server.inactive?
          out << "<td>#{image_tag 'server-inactive.png'}<br />#{server.name}</td>"
        else
          out << "<td>#{image_tag 'server.png'}<br />#{server.name}</td>"
        end
    end
    out.html_safe
  end

  def server_software_info(server)
#    out = "#{Deployment.by_server_id(server.id).last.application_name} #{Deployment.by_server_id(server.id).last.build_number}"
    out = ""
    out.html_safe
  end

  def server_operations_buttons(server)
    out = ""
    if server.deployable?
      out << link_to("clear logs!", clear_logs_server_path(:id => server.id), :class => 'btn btn-primary')
      out << link_to("restart tomcat!", restart_tomcat_server_path(:id => server.id), :class => 'btn btn-success')
    end
    out.html_safe
  end
end
