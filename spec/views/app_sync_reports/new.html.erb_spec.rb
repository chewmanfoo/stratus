require 'spec_helper'

describe "app_sync_reports/new" do
  before(:each) do
    assign(:app_sync_report, stub_model(AppSyncReport,
      :name => "MyString",
      :creator_id => 1,
      :subtitle => "MyString",
      :standard_environment_id => 1,
      :target_environment_id => 1,
      :header => "MyText",
      :body => "MyText",
      :footer => "MyText"
    ).as_new_record)
  end

  it "renders new app_sync_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => app_sync_reports_path, :method => "post" do
      assert_select "input#app_sync_report_name", :name => "app_sync_report[name]"
      assert_select "input#app_sync_report_creator_id", :name => "app_sync_report[creator_id]"
      assert_select "input#app_sync_report_subtitle", :name => "app_sync_report[subtitle]"
      assert_select "input#app_sync_report_standard_environment_id", :name => "app_sync_report[standard_environment_id]"
      assert_select "input#app_sync_report_target_environment_id", :name => "app_sync_report[target_environment_id]"
      assert_select "textarea#app_sync_report_header", :name => "app_sync_report[header]"
      assert_select "textarea#app_sync_report_body", :name => "app_sync_report[body]"
      assert_select "textarea#app_sync_report_footer", :name => "app_sync_report[footer]"
    end
  end
end
