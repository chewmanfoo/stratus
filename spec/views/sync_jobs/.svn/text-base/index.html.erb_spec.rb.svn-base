require 'spec_helper'

describe "sync_jobs/index" do
  before(:each) do
    assign(:sync_jobs, [
      stub_model(SyncJob,
        :exceptions => "MyText",
        :started_by => 1,
        :workflow_state => "Workflow State"
      ),
      stub_model(SyncJob,
        :exceptions => "MyText",
        :started_by => 1,
        :workflow_state => "Workflow State"
      )
    ])
  end

  it "renders a list of sync_jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Workflow State".to_s, :count => 2
  end
end
