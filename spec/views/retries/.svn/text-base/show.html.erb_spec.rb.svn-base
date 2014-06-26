require 'spec_helper'

describe "retries/show" do
  before(:each) do
    @retry = assign(:retry, stub_model(Retry,
      :workflow_state => "Workflow State",
      :deployment => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Workflow State/)
    rendered.should match(//)
  end
end
