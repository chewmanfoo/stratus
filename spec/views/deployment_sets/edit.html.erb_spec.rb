require 'spec_helper'

describe "deployment_sets/edit" do
  before(:each) do
    @deployment_set = assign(:deployment_set, stub_model(DeploymentSet,
      :application_id => 1,
      :build_number => "MyString",
      :run_pre_checkout => false,
      :run_post_checkout => false,
      :changelist => "MyText",
      :auto_accept => false,
      :auto_start => false,
      :created_by => 1
    ))
  end

  it "renders the edit deployment_set form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deployment_set_path(@deployment_set), "post" do
      assert_select "input#deployment_set_application_id[name=?]", "deployment_set[application_id]"
      assert_select "input#deployment_set_build_number[name=?]", "deployment_set[build_number]"
      assert_select "input#deployment_set_run_pre_checkout[name=?]", "deployment_set[run_pre_checkout]"
      assert_select "input#deployment_set_run_post_checkout[name=?]", "deployment_set[run_post_checkout]"
      assert_select "textarea#deployment_set_changelist[name=?]", "deployment_set[changelist]"
      assert_select "input#deployment_set_auto_accept[name=?]", "deployment_set[auto_accept]"
      assert_select "input#deployment_set_auto_start[name=?]", "deployment_set[auto_start]"
      assert_select "input#deployment_set_created_by[name=?]", "deployment_set[created_by]"
    end
  end
end
