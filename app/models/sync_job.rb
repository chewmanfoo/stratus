class SyncJob < ActiveRecord::Base
  include Workflow

  attr_accessible :completed_at, :exceptions, :started_at, :started_by, 
                  :environment_id, :workflow_state

  belongs_to :starter, :class_name => "User", :foreign_key => :started_by
  belongs_to :environment
  
  delegate :name, :to => :environment, :prefix => true, :allow_nil => true
  delegate :given_name, :to => :starter, :prefix => true, :allow_nil => true
  delegate :email, :to => :starter, :prefix => true, :allow_nil => true

#**********************************************************************************
# Workflow
#**********************************************************************************
  workflow do
    state :new do
      event :start, :transitions_to => :running
    end
    state :running do
      event :complete, :transitions_to => :completed

      on_entry do
logger.info "********************** self.started_at: #{self.started_at} *************************"
        case type
          when "ApplicationSyncJob"
            ApplicationSyncJobWorker.perform_async(id)
          when "RoleSyncJob"
            RoleSyncJobWorker.perform_async(id)
          when "ServerSyncJob"
            ServerSyncJobWorker.perform_async(id)
          else
            logger.error "SyncJob Workflow: I was told to execute for a SyncJob which wasn't a child!"
        end
      end
    end
    state :completed do
    
      on_entry do
        self.completed_at = Time.now
      end
    end
  end

#**********************************************************************************
# Scopes
#**********************************************************************************
  scope :last_run, :conditions => ["completed_at is NOT NULL"], :order => "id", :limit => 1
  scope :inflight, :conditions => ["started_at is NOT NULL AND workflow_state <> 'completed'"]
  
end
