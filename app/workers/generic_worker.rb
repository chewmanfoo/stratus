class GenericWorker
  include Sidekiq::Worker    
#  sidekiq_options :queue => :critical

  class OutOfOrderException < StandardError
  end

  class UnixFailedExitException < StandardError
  end

  class UnapprovedException < StandardError
  end

  class SwitchPrepFailedException < StandardError
  end

  class ServersFileMalformedException < StandardError
  end

  class UserTerminatedException < StandardError
  end

  class DeploymentServersUnavailableException < StandardError
  end

  class CouldNotCreateDeploymentException < StandardError
  end

  class GenericStopWaitException < StandardError
  end

  class GenericWorkflowException < StandardError
  end

  def mark_retry(worker_name, event)
    
  end

  def check_terminated(worker_name, event)
    event.class.log_result(event, "#{worker_name}::check_terminated -> executing")
    @ec = true
    if event.terminated?
      event.class.log_result(event, "#{worker_name}::check_terminated -> raised UserTerminatedException")
      @ec = false
    end
    return @ec
  end

  def check_order(worker_name, event, state)
    event.class.log_result(event, "#{worker_name}::check_order -> executing")
    @ec = true
    event.update_attribute(:in_retry, false)
    if event.current_state > state.to_sym
      raise GenericWorkflowException
    end
    if event.current_state.to_s != state 
      event.class.log_result(event, "#{worker_name}::check_order -> raised OutOfOrderException -- current_state is [#{event.current_state.to_s}] -- proposed state is [#{state}]")
      event.update_attribute(:in_retry, true)
      @ec = false
    end
    return @ec
  end

  def perform_unix(worker_name, event, command)
    event.class.log_result(event, "#{worker_name}::perform_unix -> executing: [#{command}]")
    @ec = true
    event.update_attribute(:in_retry, false)
    @result = `#{command} 2>&1`
    unless $?.exitstatus.zero? 
      event.class.log_result(event, "#{worker_name}::perform_unix -> raised UnixFailedExitException")
      event.class.log_result(event, "#{worker_name}::perform_unix -> FAIL: [#{@result}]")
      event.update_attribute(:in_retry, true)
      @ec = false
    end
    if ["SyncmanifestSwitchWorker","SyncmanifestDeploymentWorker"].include?(worker_name)
      unless @result.include?("Manifest sync")
        event.class.log_result(event, "#{worker_name}::perform_unix -> raised UnixFailedExitException")
        event.class.log_result(event, "#{worker_name}::perform_unix -> FAIL: [#{@result}]")
        event.class.log_result(event, "#{worker_name}::perform_unix -> FAIL: false-positive - syncmanifest did not sync")
        event.update_attribute(:in_retry, true)
        @ec = false
      end
    end
    if ["DeployDeploymentWorker"].include?(worker_name)
      unless @result.include?(event.build_number)
        event.class.log_result(event, "#{worker_name}::perform_unix -> raised UnixFailedExitException")
        event.class.log_result(event, "#{worker_name}::perform_unix -> FAIL: [#{@result}]")
        event.class.log_result(event, "#{worker_name}::perform_unix -> FAIL: false-positive -  puppet did not detect build number change")
        event.update_attribute(:in_retry, true)
        @ec = false
      end
      SystemConfiguration.in_effect.deployment_kod_array.each do |k| 
        if @result.include?(k)
          event.class.log_result(event, "#{worker_name}::perform_unix -> raised UnixFailedExitException")
          event.class.log_result(event, "#{worker_name}::perform_unix -> FAIL: [#{@result}]")
          event.class.log_result(event, "#{worker_name}::perform_unix -> FAIL: Puppet failure (result contained puppet errors)")
          event.update_attribute(:in_retry, true)
          @ec = false
        end
      end
    end
    return @ec
  end

  def perform_unix_verify_result(worker_name, event, command, check, comp)
    event.class.log_result(event, "#{worker_name}::perform_unix_verify_result -> executing: [#{command}]")
    @ec = true
    event.update_attribute(:in_retry, false)
    @result = `#{command} 2>&1`
    @ec = true
    unless @result.chomp >= comp
      event.class.log_result(event, "#{worker_name}::perform_unix_verify_result -> raised UnixFailedExitException")
      event.class.log_result(event, "#{worker_name}::perform_unix_verify_result -> FAIL: [#{@result}]")
      event.class.log_result(event, "#{worker_name}::perform_unix_verify_result -> FAIL: target server did not contain result >= #{comp}")
      event.update_attribute(:in_retry, true)
      @ec = false
    end    
  end

  def perform_unix_record_result(worker_name, event, command, attribute)
    event.class.log_result(event, "#{worker_name}::perform_unix -> executing: [#{command}]")
    @result = `#{command} 2>&1`
    @retrieved = @result.chomp
    if $?.exitstatus.zero?
      obj_class = event.class
      if obj_class.column_names.include?(attribute)
        event.update_attribute(attribute.to_sym, @retrieved)
      end
    else
      if @retrieved.include? "is not installed"
        event.class.log_result(event, "#{worker_name}::perform_unix_record_result -> OK: got result: #{@retrieved}")
        true
      else
        event.class.log_result(event, "#{worker_name}::perform_unix_record_result -> raised UnixFailedExitException")
        event.class.log_result(event, "#{worker_name}::perform_unix_record_result -> FAIL: got result: #{@retrieved}")
        false
      end
    end
  end

  def perform(*args)
    begin
      @ssh_cmd = "ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{MGMT_SERVER}"
      @ssh_t_cmd = "ssh -t -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{MGMT_SERVER}"
      @ssh_t_t_cmd = "ssh -t -t -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no #{MGMT_SERVER}"
      do_perform(*args) # implemented by subclass
    rescue OutOfOrderException => e
      logger.error "I caught an OutOfOrderException! #{e.message}"
      raise OutOfOrderException
    rescue UnixFailedExitException => e
      logger.error "I caught an UnixFailedExitException! #{e.message}"
      raise UnixFailedExitException
    rescue UnapprovedException => e
      logger.error "I caught an UnapprovedException! #{e.message}"
      raise UnapprovedException
    rescue SwitchPrepFailedException => e
      logger.error "I caught a SwitchPrepFailedException! #{e.message}"
      raise SwitchPrepFailedException
    rescue ServersFileMalformedException => e
      logger.error "I caught a ServersFileMalformedException! #{e.message}"
      raise ServersFileMalformedException
    rescue UserTerminatedException => e
      logger.error "I caught a UserTerminatedException! #{e.message}"
    rescue DeploymentServersUnavailableException => e
      logger.error "I caught a DeploymentServersUnavailableException! #{e.message}"
    rescue CouldNotCreateDeploymentException => e
      logger.error "I caught a CouldNotCreateDeploymentException! #{e.message}"
    rescue GenericStopWaitException => e
      logger.error "I caught a GenericStopWaitException! #{e.message}"
    rescue GenericWorkflowException => e
      logger.error "I caught a GenericWorkflowException! #{e.message}"
    rescue Exception => e
      logger.error "Shyte! I caught an unknown Exception! #{e.message}"
      raise Exception
    end
  end

end
