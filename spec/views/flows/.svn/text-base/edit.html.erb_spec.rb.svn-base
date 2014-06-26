require 'spec_helper'

describe "flows/edit" do
  before(:each) do
    @flow = assign(:flow, stub_model(Flow,
      :name => "MyString",
      :environment => nil,
      :role => nil,
      :application => nil,
      :build_number => "MyString",
      :latest => false,
      :reason => "MyText",
      :flow_part => nil
    ))
  end

  it "renders the edit flow form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", flow_path(@flow), "post" do
      assert_select "input#flow_name[name=?]", "flow[name]"
      assert_select "input#flow_environment[name=?]", "flow[environment]"
      assert_select "input#flow_role[name=?]", "flow[role]"
      assert_select "input#flow_application[name=?]", "flow[application]"
      assert_select "input#flow_build_number[name=?]", "flow[build_number]"
      assert_select "input#flow_latest[name=?]", "flow[latest]"
      assert_select "textarea#flow_reason[name=?]", "flow[reason]"
      assert_select "input#flow_flow_part[name=?]", "flow[flow_part]"
    end
  end
end
