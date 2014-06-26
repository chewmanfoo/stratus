class ApprovedBuild < ActiveRecord::Base
  attr_accessible :application_name, :build_number

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :by_application_name, lambda{ |a| where(application_name: a) }
  scope :by_build_number, lambda{ |b| where(build_number: b) }
  scope :by_application_name_by_build_number, lambda{ |a,b| by_application_name(a) && by_build_number(b) }

end
