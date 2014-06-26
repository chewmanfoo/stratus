class LatestRelease < ActiveRecord::Base
  attr_accessible :name

  def self.latest_batch
    @config = SystemConfiguration.in_effect
    where("version is not NULL and version <> ''").order("updated_at desc").limit(@config.num_latest_releases).sort_by(&:version)
  end
end
