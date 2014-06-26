class UsefulLink < ActiveRecord::Base
  attr_accessible :active, :icon_id, :name, :url

  belongs_to :icon

  delegate :name, :to => :icon, :prefix => true, :allow_nil => true  

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :sorted_by_name, :conditions => ["name is NOT NULL"], :order => "name"

end
