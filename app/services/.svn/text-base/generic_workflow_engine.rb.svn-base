class GenericWorkflowEngine
require 'sidekiq/api'
  
#  def initialize(id, config_id)
#    @config = SystemConfiguration.find(config_id)
#    @timer = TimerServiceDeploymentClient.new(@deployment.id, @config.id)
#  end

#  def term
#    do_terminate(@deployment.id)
#  end

  def send_email
    begin
      yield
    rescue Errno::ECONNREFUSED
      Rails.logger.info "can't connect to sendmail?"
    end if @config.send_emails?
  end

  def do_terminate(id)
    rm_arr = [id]
    rq = Sidekiq::RetrySet.new
    rq.select do |job|
      rm_arr.include?(job.args.first)
    end.map(&:delete)
  end

  def send_timing(class_name, obj, name, speaker="stratus.crt", action, subaction, event, details)
    if @config.use_timer_service?
      if @timer.send_msg(name, speaker, action, subaction, event, details)
        class_name.constantize.log_result(obj, "#{class_name} contacted TimerService for [name: #{name}, speaker: #{speaker}, action: #{action}, subaction: #{subaction}, event: #{event}, details: #{details}]")
      else
        class_name.constantize.log_result(obj, "#{class_name} could not contact TimerService for [name: #{name}, speaker: #{speaker}, action: #{action}, subaction: #{subaction}, event: #{event}, details: #{details}]")
      end
    end
  end
end
