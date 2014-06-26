require 'spec_helper'

describe "esr_works/index" do
  before(:each) do
    assign(:esr_works, [
      stub_model(EsrWork,
        :name => "Name"
      ),
      stub_model(EsrWork,
        :name => "Name"
      )
    ])
  end

  it "renders a list of esr_works" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
