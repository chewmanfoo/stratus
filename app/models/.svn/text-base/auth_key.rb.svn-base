class AuthKey < ActiveRecord::Base
  before_save :encrypt_key

  attr_accessible :active, :authorized_host_ip, :created_by, :key, :name, :seed, :salt

  belongs_to :creator, :class_name => "User", :foreign_key => :created_by
  
  delegate :given_name, :to => :creator, :prefix => true, :allow_nil => true

  validates :name, :seed, :presence => true

#**********************************************************************************
# Scopes
#**********************************************************************************

  scope :active, where(:active => true)

private 
  def encrypt_key
    if seed.present?
      self.salt = BCrypt::Engine.generate_salt
      self.key = BCrypt::Engine.hash_secret(seed, salt)
    end
  end
end
