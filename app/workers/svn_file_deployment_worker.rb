class SvnFileDeploymentWorker < GenericWorker
  require 'tmpdir'

  def do_perform(event_id)
    @event = Deployment.find(event_id)
    @config = SystemConfiguration.in_effect

    raise UserTerminatedException unless check_terminated("SvnFileDeploymentWorker", @event)

    raise OutOfOrderException unless check_order("SvnFileDeploymentWorker", @event, "subversion_file")

    @event.class.log_result(@event, "SvnFileDeploymentWorker::perform -> start")

    if @config.debug_mode?
       @event.class.log_result(@event, "SvnFileDeploymentWorker::perform -> debug mode")
    else
      @svn_path = @event.svn_path
      @svn_file = @event.svn_file

      Dir.mktmpdir do |dir|
        @task = "svn co #{@svn_path} #{dir}"
        @marker = @event.application_name
        @version = @event.version

        raise UnixFailedExitException unless perform_unix("SvnFileDeploymentWorker", @event, @task)

#'s/tvl-webapp,.*$/tvl-webapp,12.13.128-1/' 

        @prep = "grep #{@marker} #{dir}/#{@event.svn_file}"
        raise UnixFailedExitException unless perform_unix("SvnFileDeploymentWorker", @event, @prep)

        @task = "sed -i 's/#{@marker},.*$/#{@marker},#{@version}/g' #{dir}/#{@event.svn_file}"

        raise UnixFailedExitException unless perform_unix("SvnFileDeploymentWorker", @event, @task)

        @task = "svn ci -m 'update from stratus by #{@event.starter_given_name}' #{dir}/#{@event.svn_file} --username #{@event.starter_svn_login} --password '#{@event.starter_svn_password}' --no-auth-cache"

        raise UnixFailedExitException unless perform_unix("SvnFileDeploymentWorker", @event, @task)
      end
    end

    @event.class.log_result(@event, "SvnFileDeploymentWorker::perform -> end")
    @event.class.log_result(@event, "SvnFileDeploymentWorker::perform -> SUCCESS: [#{@result}]")
    @event.proceed_syncmanifest!
  end

end
