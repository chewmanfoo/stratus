require 'spec_helper'

describe "sync_jobs/new" do
  before(:each) do
    assign(:sync_job, stub_model(SyncJob,
      :exceptions => "MyText",
      :started_by => 1,
      :workflow_state => "MyString"
    ).as_new_record)
  end

  it "renders new sync_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sync_jobs_path, "post" do
      assert_select "textarea#sync_job_exceptions[name=?]", "sync_job[exceptions]"
      assert_select "input#sync_job_started_by[name=?]", "sync_job[started_by]"
      assert_select "input#sync_job_workflow_state[name=?]", "sync_job[workflow_state]"
    end
  end
end
