require 'spec_helper'

describe "role_sync_jobs/new" do
  before(:each) do
    assign(:role_sync_job, stub_model(RoleSyncJob).as_new_record)
  end

  it "renders new role_sync_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", role_sync_jobs_path, "post" do
    end
  end
end
