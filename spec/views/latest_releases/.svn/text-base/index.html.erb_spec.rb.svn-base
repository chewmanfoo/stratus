require 'spec_helper'

describe "latest_releases/index" do
  before(:each) do
    assign(:latest_releases, [
      stub_model(LatestRelease,
        :name => "Name"
      ),
      stub_model(LatestRelease,
        :name => "Name"
      )
    ])
  end

  it "renders a list of latest_releases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
