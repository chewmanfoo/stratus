class ApplicationsSyncReportController < ApplicationController
  def index
     @latest_releases = LatestRelease.latest_batch
  end
end
