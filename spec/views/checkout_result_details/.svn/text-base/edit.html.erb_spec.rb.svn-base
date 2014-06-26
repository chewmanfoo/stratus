require 'spec_helper'

describe "checkout_result_details/edit" do
  before(:each) do
    @checkout_result_detail = assign(:checkout_result_detail, stub_model(CheckoutResultDetail,
      :name => "MyString",
      :result => "MyText",
      :checkout_result_id => 1
    ))
  end

  it "renders the edit checkout_result_detail form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkout_result_details_path(@checkout_result_detail), :method => "post" do
      assert_select "input#checkout_result_detail_name", :name => "checkout_result_detail[name]"
      assert_select "textarea#checkout_result_detail_result", :name => "checkout_result_detail[result]"
      assert_select "input#checkout_result_detail_checkout_result_id", :name => "checkout_result_detail[checkout_result_id]"
    end
  end
end
