class CheckoutResult < ActiveRecord::Base
  include Workflow

  attr_accessible :last_run_at, :name, :server_id, :workflow_state

  has_many :checkout_result_details, :order => 'name DESC'
  belongs_to :server

  validates :name, presence: true

  alias_attribute :executed_at, :last_run_at

  workflow do
    state :new do
      event :execute, :transitions_to => :executing
    end
    state :executing do
      event :complete, :transitions_to => :waiting
      
      on_entry do
        CheckoutWorker.perform_async(self.id)
      end
    end  
    state :waiting do
      event :execute, :transitions_to => :executing
    end
  end
end
