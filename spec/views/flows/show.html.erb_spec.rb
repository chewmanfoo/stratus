require 'spec_helper'

describe "flows/show" do
  before(:each) do
    @flow = assign(:flow, stub_model(Flow,
      :name => "Name",
      :environment => nil,
      :role => nil,
      :application => nil,
      :build_number => "Build Number",
      :latest => false,
      :reason => "MyText",
      :flow_part => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Build Number/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(//)
  end
end
