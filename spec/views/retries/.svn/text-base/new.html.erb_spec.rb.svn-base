require 'spec_helper'

describe "retries/new" do
  before(:each) do
    assign(:retry, stub_model(Retry,
      :workflow_state => "MyString",
      :deployment => nil
    ).as_new_record)
  end

  it "renders new retry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", retries_path, "post" do
      assert_select "input#retry_workflow_state[name=?]", "retry[workflow_state]"
      assert_select "input#retry_deployment[name=?]", "retry[deployment]"
    end
  end
end
