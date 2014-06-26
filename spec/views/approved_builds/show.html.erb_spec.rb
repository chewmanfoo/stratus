require 'spec_helper'

describe "approved_builds/show" do
  before(:each) do
    @approved_build = assign(:approved_build, stub_model(ApprovedBuild,
      :application_name => "Application Name",
      :build_number => "Build Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Application Name/)
    rendered.should match(/Build Number/)
  end
end
