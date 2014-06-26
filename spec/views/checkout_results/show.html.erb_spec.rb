require 'spec_helper'

describe "checkout_results/show" do
  before(:each) do
    @checkout_result = assign(:checkout_result, stub_model(CheckoutResult,
      :name => "Name",
      :server_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
  end
end
