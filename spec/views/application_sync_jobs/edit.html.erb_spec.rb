require 'spec_helper'

describe "application_sync_jobs/edit" do
  before(:each) do
    @application_sync_job = assign(:application_sync_job, stub_model(ApplicationSyncJob))
  end

  it "renders the edit application_sync_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", application_sync_job_path(@application_sync_job), "post" do
    end
  end
end
