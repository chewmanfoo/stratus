require 'spec_helper'

describe "flow_parts/new" do
  before(:each) do
    assign(:flow_part, stub_model(FlowPart,
      :name => "MyString",
      :chore => nil,
      :flow_part => nil
    ).as_new_record)
  end

  it "renders new flow_part form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", flow_parts_path, "post" do
      assert_select "input#flow_part_name[name=?]", "flow_part[name]"
      assert_select "input#flow_part_chore[name=?]", "flow_part[chore]"
      assert_select "input#flow_part_flow_part[name=?]", "flow_part[flow_part]"
    end
  end
end
