require 'spec_helper'

describe "role_sync_jobs/index" do
  before(:each) do
    assign(:role_sync_jobs, [
      stub_model(RoleSyncJob),
      stub_model(RoleSyncJob)
    ])
  end

  it "renders a list of role_sync_jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
