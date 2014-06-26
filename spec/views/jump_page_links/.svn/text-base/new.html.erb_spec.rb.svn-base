require 'spec_helper'

describe "jump_page_links/new" do
  before(:each) do
    assign(:jump_page_link, stub_model(JumpPageLink,
      :name => "MyString",
      :url => "MyString",
      :application_id => 1
    ).as_new_record)
  end

  it "renders new jump_page_link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", jump_page_links_path, "post" do
      assert_select "input#jump_page_link_name[name=?]", "jump_page_link[name]"
      assert_select "input#jump_page_link_url[name=?]", "jump_page_link[url]"
      assert_select "input#jump_page_link_application_id[name=?]", "jump_page_link[application_id]"
    end
  end
end
