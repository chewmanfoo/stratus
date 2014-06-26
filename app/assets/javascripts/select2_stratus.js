function format(icon) {
            if (!icon.id) return icon.text; // optgroup
            return "<i class='" + icon.text + "'></i> " + icon.text; 
        }

$(function() {
  $("#deployment_application_id").select2({placeholder: "Select an Application"});
  $("#deployment_role_id").select2({placeholder: "Select a Role"});
  $("#deployment_environment_id").select2({placeholder: "Select an Environment"});
  $("#deployment_mail_recipient_id").select2({placeholder: "Select an Mail Recipient"});
  $("#deployment_set_application_id").select2({placeholder: "Select an Application"});
  $("#deployment_set_role_id").select2({placeholder: "Select a Role"});
  $("#deployment_set_environment_id").select2({placeholder: "Select an Environment"});
  $("#deployment_set_mail_recipient_id").select2({placeholder: "Select an Mail Recipient"});
  $("#switch_role_id").select2({placeholder: "Select a Role"});
  $("#switch_environment_id").select2({placeholder: "Select an Environment"});
  $("#switch_mail_recipient_id").select2({placeholder: "Select an Mail Recipient"});
  $("#useful_link_icon_id").select2({
            formatResult: format,
            formatSelection: format,
            placeholder: "Select an Icon"
  });
});
