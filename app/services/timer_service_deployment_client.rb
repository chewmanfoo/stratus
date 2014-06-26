class TimerServiceDeploymentClient < TimerServiceEngine 
require 'sidekiq/api'

  def initialize(id, config_id)
    @deployment = Deployment.find(id)
    @config = SystemConfiguration.find(config_id)
  end

  def send_msg(name, speaker, action, subaction, event, details)
  end 
end
