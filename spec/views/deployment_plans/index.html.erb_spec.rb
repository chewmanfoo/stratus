require 'spec_helper'

describe "deployment_plans/index" do
  before(:each) do
    assign(:deployment_plans, [
      stub_model(DeploymentPlan,
        :name => "Name",
        :application => nil,
        :mail_recipient => nil
      ),
      stub_model(DeploymentPlan,
        :name => "Name",
        :application => nil,
        :mail_recipient => nil
      )
    ])
  end

  it "renders a list of deployment_plans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
