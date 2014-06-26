class Suggestion < ActiveRecord::Base
  attr_accessible :body, :name

  validates :name, :body, :presence => true
end
