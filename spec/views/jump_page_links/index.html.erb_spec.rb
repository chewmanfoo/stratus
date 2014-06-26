require 'spec_helper'

describe "jump_page_links/index" do
  before(:each) do
    assign(:jump_page_links, [
      stub_model(JumpPageLink,
        :name => "Name",
        :url => "Url",
        :application_id => 1
      ),
      stub_model(JumpPageLink,
        :name => "Name",
        :url => "Url",
        :application_id => 1
      )
    ])
  end

  it "renders a list of jump_page_links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
