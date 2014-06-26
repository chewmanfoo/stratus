require 'spec_helper'

describe "chores/new" do
  before(:each) do
    assign(:chore, stub_model(Chore,
      :name => "MyString",
      :command => "MyString",
      :success => "MyString",
      :fail => "MyString"
    ).as_new_record)
  end

  it "renders new chore form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", chores_path, "post" do
      assert_select "input#chore_name[name=?]", "chore[name]"
      assert_select "input#chore_command[name=?]", "chore[command]"
      assert_select "input#chore_success[name=?]", "chore[success]"
      assert_select "input#chore_fail[name=?]", "chore[fail]"
    end
  end
end
