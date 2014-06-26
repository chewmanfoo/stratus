require 'spec_helper'

describe "deployment_plans/show" do
  before(:each) do
    @deployment_plan = assign(:deployment_plan, stub_model(DeploymentPlan,
      :name => "Name",
      :application => nil,
      :mail_recipient => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
