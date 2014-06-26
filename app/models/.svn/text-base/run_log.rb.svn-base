class RunLog < ActiveRecord::Base
  before_save :mask_passwords
  attr_accessible :log, :type

private
  def mask_passwords
    log.gsub!(/--password .*$/,"--password [MASKED]")
  end
end
