require 'spec_helper'

describe "application_sync_jobs/new" do
  before(:each) do
    assign(:application_sync_job, stub_model(ApplicationSyncJob).as_new_record)
  end

  it "renders new application_sync_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", application_sync_jobs_path, "post" do
    end
  end
end
