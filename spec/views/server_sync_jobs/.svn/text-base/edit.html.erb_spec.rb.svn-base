require 'spec_helper'

describe "server_sync_jobs/edit" do
  before(:each) do
    @server_sync_job = assign(:server_sync_job, stub_model(ServerSyncJob))
  end

  it "renders the edit server_sync_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_sync_job_path(@server_sync_job), "post" do
    end
  end
end
