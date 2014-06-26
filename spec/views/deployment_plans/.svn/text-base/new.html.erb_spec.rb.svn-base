require 'spec_helper'

describe "deployment_plans/new" do
  before(:each) do
    assign(:deployment_plan, stub_model(DeploymentPlan,
      :name => "MyString",
      :application => nil,
      :mail_recipient => nil
    ).as_new_record)
  end

  it "renders new deployment_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deployment_plans_path, "post" do
      assert_select "input#deployment_plan_name[name=?]", "deployment_plan[name]"
      assert_select "input#deployment_plan_application[name=?]", "deployment_plan[application]"
      assert_select "input#deployment_plan_mail_recipient[name=?]", "deployment_plan[mail_recipient]"
    end
  end
end
