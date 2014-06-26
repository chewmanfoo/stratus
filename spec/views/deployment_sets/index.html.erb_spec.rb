require 'spec_helper'

describe "deployment_sets/index" do
  before(:each) do
    assign(:deployment_sets, [
      stub_model(DeploymentSet,
        :application_id => 1,
        :build_number => "Build Number",
        :run_pre_checkout => false,
        :run_post_checkout => false,
        :changelist => "MyText",
        :auto_accept => false,
        :auto_start => false,
        :created_by => 2
      ),
      stub_model(DeploymentSet,
        :application_id => 1,
        :build_number => "Build Number",
        :run_pre_checkout => false,
        :run_post_checkout => false,
        :changelist => "MyText",
        :auto_accept => false,
        :auto_start => false,
        :created_by => 2
      )
    ])
  end

  it "renders a list of deployment_sets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Build Number".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
