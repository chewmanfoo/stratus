module UsersHelper

  def refresh_auth_token_button(u)
    out = ""
    out << link_to("generate!", refresh_token_user_path(:id => u.id), :class => 'btn btn-mini btn-success') 
    out.html_safe
  end
end
