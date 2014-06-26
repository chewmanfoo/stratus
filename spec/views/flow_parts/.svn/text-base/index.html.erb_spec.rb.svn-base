require 'spec_helper'

describe "flow_parts/index" do
  before(:each) do
    assign(:flow_parts, [
      stub_model(FlowPart,
        :name => "Name",
        :chore => nil,
        :flow_part => nil
      ),
      stub_model(FlowPart,
        :name => "Name",
        :chore => nil,
        :flow_part => nil
      )
    ])
  end

  it "renders a list of flow_parts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
