require 'spec_helper'

describe "app_sync_reports/show" do
  before(:each) do
    @app_sync_report = assign(:app_sync_report, stub_model(AppSyncReport,
      :name => "Name",
      :creator_id => 1,
      :subtitle => "Subtitle",
      :standard_environment_id => 2,
      :target_environment_id => 3,
      :header => "MyText",
      :body => "MyText",
      :footer => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/Subtitle/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
