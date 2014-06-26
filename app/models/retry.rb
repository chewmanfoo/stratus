class Retry < ActiveRecord::Base
  belongs_to :deployment
  attr_accessible :workflow_state
end
