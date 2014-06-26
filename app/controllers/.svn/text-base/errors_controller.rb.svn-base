class ErrorsController < ApplicationController
  def error_404
    @not_found_path = params[:not_found]
    @config = SystemConfiguration.in_effect
    @useful_links = UsefulLink.all.sort_by(&:name)
    @start_datetime = Time.now
    @latest_releases = LatestRelease.latest_batch
  end

  def error_500
    @config = SystemConfiguration.in_effect
    @useful_links = UsefulLink.all.sort_by(&:name)
    @start_datetime = Time.now

    @backtrace = Exception#backtrace
    rescue_from Exception do |exception|
      logger.error exception.class
      logger.error exception.message
      logger.error exception.backtrace.join "\n"
      @exception = exception
    end
  end
end
