require 'spec_helper'

describe "retries/edit" do
  before(:each) do
    @retry = assign(:retry, stub_model(Retry,
      :workflow_state => "MyString",
      :deployment => nil
    ))
  end

  it "renders the edit retry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", retry_path(@retry), "post" do
      assert_select "input#retry_workflow_state[name=?]", "retry[workflow_state]"
      assert_select "input#retry_deployment[name=?]", "retry[deployment]"
    end
  end
end
