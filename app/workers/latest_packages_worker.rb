class LatestPackagesWorker < GenericWorker

  def do_perform(latest_pkg_id)
    @latest_pkg = LatestRelease.find(latest_pkg_id)

#    @latest_pkg.class.log_result(@latest_pkg, "LatestPackagesWorker::perform -> start")

    @task = "#{@ssh_cmd} check_dsl -t -q -p #{@latest_pkg.name}"

    raise UnixFailedExitException unless perform_unix_record_result("LatestPackagesWorker", @latest_pkg, @task, "version")  

#    @latest_pkg.class.log_result(@latest_pkg, "LatestPackagesWorker::perform -> end")
#    @latest_pkg.class.log_result(@latest_pkg, "LatestPackagesWorker::perform -> SUCCESS: [#{@result}]")

# requeue 
    unless LatestRelease.latest_batch.include?(@latest_pkg)
      r = Random.new
      LatestPackagesWorker.perform_in(r.rand(10..60).minutes,latest_pkg_id)    
    end
  end

end
