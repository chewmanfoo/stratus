require 'spec_helper'

describe "server_sync_jobs/new" do
  before(:each) do
    assign(:server_sync_job, stub_model(ServerSyncJob).as_new_record)
  end

  it "renders new server_sync_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_sync_jobs_path, "post" do
    end
  end
end
