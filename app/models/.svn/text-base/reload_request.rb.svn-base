class ReloadRequest < ActiveRecord::Base
  attr_accessible :build_number, :email_notification_list, :environment_id, :latest, :package, :role_id, :to_release_at

  belongs_to :role
  belongs_to :environment

  validates :package, :presence => true
  validates :build_number, :presence => true, :unless => :latest? 

end
