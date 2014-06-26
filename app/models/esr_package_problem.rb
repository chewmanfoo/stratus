class EsrPackageProblem < ActiveRecord::Base
  attr_accessible :conflict, :environment_sync_report_id, :package_id, :target_version, :trusted_version

  belongs_to :environment_sync_report
  belongs_to :package, :class_name => "Application", :foreign_key => :package_id

  delegate :name, :to => :environment_sync_report, :prefix => true, :allow_nil => true
  delegate :name, :to => :package, :prefix => true, :allow_nil => true

  validates :conflict, :inclusion => { :in => ["belongs to trusted but not target","belongs to target but not trusted","trusted version is higher","target version is higher"], :message => "%{value} is not a valid conflict type" }

  def self.conflicts
    ["belongs to trusted but not target",
     "belongs to target but not trusted",
     "trusted version is higher", 
     "target version is higher"]
  end

end
