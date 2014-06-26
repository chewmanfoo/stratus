require 'spec_helper'

describe "flow_parts/show" do
  before(:each) do
    @flow_part = assign(:flow_part, stub_model(FlowPart,
      :name => "Name",
      :chore => nil,
      :flow_part => nil
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
