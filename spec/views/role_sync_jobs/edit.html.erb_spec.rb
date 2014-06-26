require 'spec_helper'

describe "role_sync_jobs/edit" do
  before(:each) do
    @role_sync_job = assign(:role_sync_job, stub_model(RoleSyncJob))
  end

  it "renders the edit role_sync_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", role_sync_job_path(@role_sync_job), "post" do
    end
  end
end
