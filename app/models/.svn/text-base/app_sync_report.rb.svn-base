class AppSyncReport < ActiveRecord::Base
  include Workflow

  attr_accessible :body, :creator_id, :footer, :header, :name, 
                  :standard_environment_id, :subtitle, :target_environment_ida,
                  :trigger_refresh, :workflow_state

  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  belongs_to :standard_environment, :class_name => "Environment", :foreign_key => :standard_environment_id
  belongs_to :target_environment, :class_name => "Environment", :foreign_key => :target_environment_id

  delegate :name, :to => :standard_environment, :prefix => true, :allow_nil => true
  delegate :name, :to => :target_environment, :prefix => true, :allow_nil => true

  def full_name
    "App Sync Report #{standard_environment_name} compared to #{target_environment_name} created at #{created_at.to_s(:pretty)}"
  end  

#**********************************************************************************
# Workflow
#**********************************************************************************
  workflow do
    state :new do
      event :prep, :transitions_to => :prepping
    end
    state :prepping do
      event :run, :transitions_to => :running
    end
    state :running do
      event :complete, :transitions_to =>:completed
      event :fail, :transitions_to =>:failed
    end
    state :complete do
    end
    state :fail do
    end
  end
end
