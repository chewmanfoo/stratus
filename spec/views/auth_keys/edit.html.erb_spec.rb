require 'spec_helper'

describe "auth_keys/edit" do
  before(:each) do
    @auth_key = assign(:auth_key, stub_model(AuthKey,
      :name => "MyString",
      :key => "MyString",
      :created_by => 1,
      :authorized_host_ip => "MyString",
      :active => false,
      :seed => "MyString"
    ))
  end

  it "renders the edit auth_key form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", auth_key_path(@auth_key), "post" do
      assert_select "input#auth_key_name[name=?]", "auth_key[name]"
      assert_select "input#auth_key_key[name=?]", "auth_key[key]"
      assert_select "input#auth_key_created_by[name=?]", "auth_key[created_by]"
      assert_select "input#auth_key_authorized_host_ip[name=?]", "auth_key[authorized_host_ip]"
      assert_select "input#auth_key_active[name=?]", "auth_key[active]"
      assert_select "input#auth_key_seed[name=?]", "auth_key[seed]"
    end
  end
end
