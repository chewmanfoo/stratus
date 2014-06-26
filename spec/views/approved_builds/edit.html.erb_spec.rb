require 'spec_helper'

describe "approved_builds/edit" do
  before(:each) do
    @approved_build = assign(:approved_build, stub_model(ApprovedBuild,
      :application_name => "MyString",
      :build_number => "MyString"
    ))
  end

  it "renders the edit approved_build form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", approved_build_path(@approved_build), "post" do
      assert_select "input#approved_build_application_name[name=?]", "approved_build[application_name]"
      assert_select "input#approved_build_build_number[name=?]", "approved_build[build_number]"
    end
  end
end
