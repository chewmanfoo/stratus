require 'spec_helper'

describe "chores/index" do
  before(:each) do
    assign(:chores, [
      stub_model(Chore,
        :name => "Name",
        :command => "Command",
        :success => "Success",
        :fail => "Fail"
      ),
      stub_model(Chore,
        :name => "Name",
        :command => "Command",
        :success => "Success",
        :fail => "Fail"
      )
    ])
  end

  it "renders a list of chores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Command".to_s, :count => 2
    assert_select "tr>td", :text => "Success".to_s, :count => 2
    assert_select "tr>td", :text => "Fail".to_s, :count => 2
  end
end
