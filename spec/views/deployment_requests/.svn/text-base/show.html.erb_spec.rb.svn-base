require 'spec_helper'

describe "deployment_requests/show" do
  before(:each) do
    @deployment_request = assign(:deployment_request, stub_model(DeploymentRequest,
      :package => "Package",
      :build => "Build",
      :environment => "Environment",
      :auth_key => "Auth Key",
      :delay => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Package/)
    rendered.should match(/Build/)
    rendered.should match(/Environment/)
    rendered.should match(/Auth Key/)
    rendered.should match(/1/)
  end
end
