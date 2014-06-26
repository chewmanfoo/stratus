require 'spec_helper'

describe "checkout_results/new" do
  before(:each) do
    assign(:checkout_result, stub_model(CheckoutResult,
      :name => "MyString",
      :server_id => 1
    ).as_new_record)
  end

  it "renders new checkout_result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkout_results_path, :method => "post" do
      assert_select "input#checkout_result_name", :name => "checkout_result[name]"
      assert_select "input#checkout_result_server_id", :name => "checkout_result[server_id]"
    end
  end
end
