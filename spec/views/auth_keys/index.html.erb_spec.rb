require 'spec_helper'

describe "auth_keys/index" do
  before(:each) do
    assign(:auth_keys, [
      stub_model(AuthKey,
        :name => "Name",
        :key => "Key",
        :created_by => 1,
        :authorized_host_ip => "Authorized Host Ip",
        :active => false,
        :seed => "Seed"
      ),
      stub_model(AuthKey,
        :name => "Name",
        :key => "Key",
        :created_by => 1,
        :authorized_host_ip => "Authorized Host Ip",
        :active => false,
        :seed => "Seed"
      )
    ])
  end

  it "renders a list of auth_keys" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Authorized Host Ip".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Seed".to_s, :count => 2
  end
end
