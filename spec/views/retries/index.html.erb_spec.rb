require 'spec_helper'

describe "retries/index" do
  before(:each) do
    assign(:retries, [
      stub_model(Retry,
        :workflow_state => "Workflow State",
        :deployment => nil
      ),
      stub_model(Retry,
        :workflow_state => "Workflow State",
        :deployment => nil
      )
    ])
  end

  it "renders a list of retries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Workflow State".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
