require 'spec_helper'

describe "environment_sync_reports/edit" do
  before(:each) do
    @environment_sync_report = assign(:environment_sync_report, stub_model(EnvironmentSyncReport,
      :trusted_environment_id => 1,
      :target_environment_id => 1,
      :work_to_perform_id => 1,
      :workflow_state => "MyString"
    ))
  end

  it "renders the edit environment_sync_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => environment_sync_reports_path(@environment_sync_report), :method => "post" do
      assert_select "input#environment_sync_report_trusted_environment_id", :name => "environment_sync_report[trusted_environment_id]"
      assert_select "input#environment_sync_report_target_environment_id", :name => "environment_sync_report[target_environment_id]"
      assert_select "input#environment_sync_report_work_to_perform_id", :name => "environment_sync_report[work_to_perform_id]"
      assert_select "input#environment_sync_report_workflow_state", :name => "environment_sync_report[workflow_state]"
    end
  end
end
