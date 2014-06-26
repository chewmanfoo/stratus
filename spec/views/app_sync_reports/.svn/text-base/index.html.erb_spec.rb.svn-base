require 'spec_helper'

describe "app_sync_reports/index" do
  before(:each) do
    assign(:app_sync_reports, [
      stub_model(AppSyncReport,
        :name => "Name",
        :creator_id => 1,
        :subtitle => "Subtitle",
        :standard_environment_id => 2,
        :target_environment_id => 3,
        :header => "MyText",
        :body => "MyText",
        :footer => "MyText"
      ),
      stub_model(AppSyncReport,
        :name => "Name",
        :creator_id => 1,
        :subtitle => "Subtitle",
        :standard_environment_id => 2,
        :target_environment_id => 3,
        :header => "MyText",
        :body => "MyText",
        :footer => "MyText"
      )
    ])
  end

  it "renders a list of app_sync_reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Subtitle".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
