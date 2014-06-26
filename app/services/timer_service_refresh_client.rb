class TimerServiceRefreshClient < TimerServiceEngine 
require 'sidekiq/api'

  def initialize(id, config_id)
    @refresh = Refresh.find(id)
    @config = SystemConfiguration.find(config_id)
  end

  def send_msg(name, speaker, action, subaction, event, details)
  end 
end
