require 'spec_helper'

describe "deployment_requests/new" do
  before(:each) do
    assign(:deployment_request, stub_model(DeploymentRequest,
      :package => "MyString",
      :build => "MyString",
      :environment => "MyString",
      :auth_key => "MyString",
      :delay => 1
    ).as_new_record)
  end

  it "renders new deployment_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", deployment_requests_path, "post" do
      assert_select "input#deployment_request_package[name=?]", "deployment_request[package]"
      assert_select "input#deployment_request_build[name=?]", "deployment_request[build]"
      assert_select "input#deployment_request_environment[name=?]", "deployment_request[environment]"
      assert_select "input#deployment_request_auth_key[name=?]", "deployment_request[auth_key]"
      assert_select "input#deployment_request_delay[name=?]", "deployment_request[delay]"
    end
  end
end
