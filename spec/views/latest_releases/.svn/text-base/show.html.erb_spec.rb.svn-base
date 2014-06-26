require 'spec_helper'

describe "latest_releases/show" do
  before(:each) do
    @latest_release = assign(:latest_release, stub_model(LatestRelease,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
