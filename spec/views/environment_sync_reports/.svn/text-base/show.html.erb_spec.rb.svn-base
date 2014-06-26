require 'spec_helper'

describe "environment_sync_reports/show" do
  before(:each) do
    @environment_sync_report = assign(:environment_sync_report, stub_model(EnvironmentSyncReport,
      :trusted_environment_id => 1,
      :target_environment_id => 2,
      :work_to_perform_id => 3,
      :workflow_state => "Workflow State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Workflow State/)
  end
end
