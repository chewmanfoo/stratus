require 'spec_helper'

describe "role_sync_jobs/show" do
  before(:each) do
    @role_sync_job = assign(:role_sync_job, stub_model(RoleSyncJob))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
