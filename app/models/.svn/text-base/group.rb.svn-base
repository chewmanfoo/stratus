class Group < ActiveRecord::Base
  attr_accessible :active, :admin, :name, 
                  :manages_users, :manages_database, :manages_threads, :manages_system,
                  :approves, :creates_deployments, :creates_switches,
                  :executes_deployments, :executes_switches, :creates_reports, :views_reports,
                  :refreshes_tripcase

  has_many :group_lists
  has_many :users, :through => :group_lists

  validates :name, :presence => true

  scope :admin, where(:admin => true)
  scope :active, where(:active => true)

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
