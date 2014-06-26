require 'spec_helper'

describe "application_sync_jobs/index" do
  before(:each) do
    assign(:application_sync_jobs, [
      stub_model(ApplicationSyncJob),
      stub_model(ApplicationSyncJob)
    ])
  end

  it "renders a list of application_sync_jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
