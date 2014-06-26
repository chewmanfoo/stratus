require 'spec_helper'

describe "checkout_result_details/index" do
  before(:each) do
    assign(:checkout_result_details, [
      stub_model(CheckoutResultDetail,
        :name => "Name",
        :result => "MyText",
        :checkout_result_id => 1
      ),
      stub_model(CheckoutResultDetail,
        :name => "Name",
        :result => "MyText",
        :checkout_result_id => 1
      )
    ])
  end

  it "renders a list of checkout_result_details" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
