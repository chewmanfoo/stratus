require 'spec_helper'

describe "checkout_result_details/show" do
  before(:each) do
    @checkout_result_detail = assign(:checkout_result_detail, stub_model(CheckoutResultDetail,
      :name => "Name",
      :result => "MyText",
      :checkout_result_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
