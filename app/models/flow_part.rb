class FlowPart < ActiveRecord::Base
  belongs_to :chore
  belongs_to :next_flow_part, :class_name => "FlowPart"
  attr_accessible :name, :next_flow_part_id, :chore_id

  delegate :name, :to => :chore, :prefix => true, :allow_nil => true
  delegate :name, :to => :next_flow_part, :prefix => true, :allow_nil => true
  delegate :command, :to => :chore, :prefix => true, :allow_nil => true
end
