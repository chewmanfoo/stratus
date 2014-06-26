require 'spec_helper'

describe "auth_keys/show" do
  before(:each) do
    @auth_key = assign(:auth_key, stub_model(AuthKey,
      :name => "Name",
      :key => "Key",
      :created_by => 1,
      :authorized_host_ip => "Authorized Host Ip",
      :active => false,
      :seed => "Seed"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Key/)
    rendered.should match(/1/)
    rendered.should match(/Authorized Host Ip/)
    rendered.should match(/false/)
    rendered.should match(/Seed/)
  end
end
