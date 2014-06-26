require 'spec_helper'

describe "deployment_requests/index" do
  before(:each) do
    assign(:deployment_requests, [
      stub_model(DeploymentRequest,
        :package => "Package",
        :build => "Build",
        :environment => "Environment",
        :auth_key => "Auth Key",
        :delay => 1
      ),
      stub_model(DeploymentRequest,
        :package => "Package",
        :build => "Build",
        :environment => "Environment",
        :auth_key => "Auth Key",
        :delay => 1
      )
    ])
  end

  it "renders a list of deployment_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Package".to_s, :count => 2
    assert_select "tr>td", :text => "Build".to_s, :count => 2
    assert_select "tr>td", :text => "Environment".to_s, :count => 2
    assert_select "tr>td", :text => "Auth Key".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
