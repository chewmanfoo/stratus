require 'spec_helper'

describe "approved_builds/index" do
  before(:each) do
    assign(:approved_builds, [
      stub_model(ApprovedBuild,
        :application_name => "Application Name",
        :build_number => "Build Number"
      ),
      stub_model(ApprovedBuild,
        :application_name => "Application Name",
        :build_number => "Build Number"
      )
    ])
  end

  it "renders a list of approved_builds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Application Name".to_s, :count => 2
    assert_select "tr>td", :text => "Build Number".to_s, :count => 2
  end
end
