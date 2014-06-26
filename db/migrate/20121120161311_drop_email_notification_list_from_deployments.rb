class DropEmailNotificationListFromDeployments < ActiveRecord::Migration
  def up
    remove_column :deployments, :email_notification_list
  end

  def down
    add_column :deployments, :email_notification_list, :text
  end
end
