class TimerServiceSwitchClient < TimerServiceEngine

  def initialize(id, config_id)
    @switch = Switch.find(id)
    @config = SystemConfiguration.find(config_id)
  end

  def send_msg(entity, action, state)
  end
end
