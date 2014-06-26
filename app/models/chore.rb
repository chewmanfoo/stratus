class Chore < ActiveRecord::Base
  attr_accessible :command, :fail, :name, :success
end
