require 'spec_helper'

describe "checkout_results/edit" do
  before(:each) do
    @checkout_result = assign(:checkout_result, stub_model(CheckoutResult,
      :name => "MyString",
      :server_id => 1
    ))
  end

  it "renders the edit checkout_result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkout_results_path(@checkout_result), :method => "post" do
      assert_select "input#checkout_result_name", :name => "checkout_result[name]"
      assert_select "input#checkout_result_server_id", :name => "checkout_result[server_id]"
    end
  end
end
