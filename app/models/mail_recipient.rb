class MailRecipient < ActiveRecord::Base
  attr_accessible :addresses, :name

  has_many :deployments
  has_many :deployment_plans

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :sorted_by_name, :conditions => ["name is NOT NULL"], :order => "name"

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

# insert addresses cleanup function - semicolon delimited only no newlines, no commas etc. 
end
