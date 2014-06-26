require 'spec_helper'

describe "esr_works/new" do
  before(:each) do
    assign(:esr_work, stub_model(EsrWork,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new esr_work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => esr_works_path, :method => "post" do
      assert_select "input#esr_work_name", :name => "esr_work[name]"
    end
  end
end
