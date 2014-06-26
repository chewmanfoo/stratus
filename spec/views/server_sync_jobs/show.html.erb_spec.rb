require 'spec_helper'

describe "server_sync_jobs/show" do
  before(:each) do
    @server_sync_job = assign(:server_sync_job, stub_model(ServerSyncJob))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
