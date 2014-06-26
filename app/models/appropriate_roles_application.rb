class AppropriateRolesApplication < ActiveRecord::Base
  attr_accessible :application_id, :role_id

  belongs_to :application
  belongs_to :role
end
