require 'spec_helper'

describe "application_sync_jobs/show" do
  before(:each) do
    @application_sync_job = assign(:application_sync_job, stub_model(ApplicationSyncJob))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
