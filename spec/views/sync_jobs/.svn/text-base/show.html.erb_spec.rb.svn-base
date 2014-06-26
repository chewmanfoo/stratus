require 'spec_helper'

describe "sync_jobs/show" do
  before(:each) do
    @sync_job = assign(:sync_job, stub_model(SyncJob,
      :exceptions => "MyText",
      :started_by => 1,
      :workflow_state => "Workflow State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Workflow State/)
  end
end
