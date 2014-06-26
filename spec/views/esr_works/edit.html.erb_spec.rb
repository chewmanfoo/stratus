require 'spec_helper'

describe "esr_works/edit" do
  before(:each) do
    @esr_work = assign(:esr_work, stub_model(EsrWork,
      :name => "MyString"
    ))
  end

  it "renders the edit esr_work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => esr_works_path(@esr_work), :method => "post" do
      assert_select "input#esr_work_name", :name => "esr_work[name]"
    end
  end
end
