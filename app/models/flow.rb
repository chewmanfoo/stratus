class Flow < ActiveRecord::Base
  belongs_to :environment
  belongs_to :role
  belongs_to :application
  belongs_to :first_flow_part, :class_name => "FlowPart"
  attr_accessible :build_number, :latest, :name, :reason, :environment_id, :role_id, :application_id, :first_flow_part_id

  delegate :name, :to => :role, :prefix => true, :allow_nil => true
  delegate :name, :to => :environment, :prefix => true, :allow_nil => true
  delegate :name, :to => :application, :prefix => true, :allow_nil => true
  delegate :name, :to => :first_flow_part, :prefix => true, :allow_nil => true

  def flow_parts_by_name_id
    # sorted first to last
    out = Hash.new
    part = first_flow_part
    until part.nil?
      out[part.name] = part.id
      part = part.next_flow_part
    end

    out
  end
end
