require 'spec_helper'

describe "refreshes/new" do
  before(:each) do
    assign(:refresh, stub_model(Refresh,
      :workflow_state => "MyString",
      :created_by => 1,
      :environment => nil,
      :role => nil,
      :changelist => "MyText"
    ).as_new_record)
  end

  it "renders new refresh form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", refreshes_path, "post" do
      assert_select "input#refresh_workflow_state[name=?]", "refresh[workflow_state]"
      assert_select "input#refresh_created_by[name=?]", "refresh[created_by]"
      assert_select "input#refresh_environment[name=?]", "refresh[environment]"
      assert_select "input#refresh_role[name=?]", "refresh[role]"
      assert_select "textarea#refresh_changelist[name=?]", "refresh[changelist]"
    end
  end
end
