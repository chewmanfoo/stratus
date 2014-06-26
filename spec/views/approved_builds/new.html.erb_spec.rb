require 'spec_helper'

describe "approved_builds/new" do
  before(:each) do
    assign(:approved_build, stub_model(ApprovedBuild,
      :application_name => "MyString",
      :build_number => "MyString"
    ).as_new_record)
  end

  it "renders new approved_build form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", approved_builds_path, "post" do
      assert_select "input#approved_build_application_name[name=?]", "approved_build[application_name]"
      assert_select "input#approved_build_build_number[name=?]", "approved_build[build_number]"
    end
  end
end
