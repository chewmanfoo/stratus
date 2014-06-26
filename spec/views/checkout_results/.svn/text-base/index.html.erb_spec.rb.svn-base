require 'spec_helper'

describe "checkout_results/index" do
  before(:each) do
    assign(:checkout_results, [
      stub_model(CheckoutResult,
        :name => "Name",
        :server_id => 1
      ),
      stub_model(CheckoutResult,
        :name => "Name",
        :server_id => 1
      )
    ])
  end

  it "renders a list of checkout_results" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
