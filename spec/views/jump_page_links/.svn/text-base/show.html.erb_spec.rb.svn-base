require 'spec_helper'

describe "jump_page_links/show" do
  before(:each) do
    @jump_page_link = assign(:jump_page_link, stub_model(JumpPageLink,
      :name => "Name",
      :url => "Url",
      :application_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Url/)
    rendered.should match(/1/)
  end
end
