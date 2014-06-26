require 'spec_helper'

describe "flows/index" do
  before(:each) do
    assign(:flows, [
      stub_model(Flow,
        :name => "Name",
        :environment => nil,
        :role => nil,
        :application => nil,
        :build_number => "Build Number",
        :latest => false,
        :reason => "MyText",
        :flow_part => nil
      ),
      stub_model(Flow,
        :name => "Name",
        :environment => nil,
        :role => nil,
        :application => nil,
        :build_number => "Build Number",
        :latest => false,
        :reason => "MyText",
        :flow_part => nil
      )
    ])
  end

  it "renders a list of flows" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Build Number".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
