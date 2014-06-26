require 'spec_helper'

describe "environment_sync_reports/index" do
  before(:each) do
    assign(:environment_sync_reports, [
      stub_model(EnvironmentSyncReport,
        :trusted_environment_id => 1,
        :target_environment_id => 2,
        :work_to_perform_id => 3,
        :workflow_state => "Workflow State"
      ),
      stub_model(EnvironmentSyncReport,
        :trusted_environment_id => 1,
        :target_environment_id => 2,
        :work_to_perform_id => 3,
        :workflow_state => "Workflow State"
      )
    ])
  end

  it "renders a list of environment_sync_reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Workflow State".to_s, :count => 2
  end
end
