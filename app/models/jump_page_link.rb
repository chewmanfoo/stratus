class JumpPageLink < ActiveRecord::Base
  attr_accessible :application_id, :name, :url

  belongs_to :application

  delegate :name, :to => :application, :prefix => true, :allow_nil => true

  validates :name, :url, :application_id, :presence => true
  

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :by_application_id, lambda{ |i| where(application_id: i) }
end
