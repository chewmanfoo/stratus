require 'spec_helper'

describe "deployment_sets/show" do
  before(:each) do
    @deployment_set = assign(:deployment_set, stub_model(DeploymentSet,
      :application_id => 1,
      :build_number => "Build Number",
      :run_pre_checkout => false,
      :run_post_checkout => false,
      :changelist => "MyText",
      :auto_accept => false,
      :auto_start => false,
      :created_by => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Build Number/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/2/)
  end
end
