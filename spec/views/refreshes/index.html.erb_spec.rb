require 'spec_helper'

describe "refreshes/index" do
  before(:each) do
    assign(:refreshes, [
      stub_model(Refresh,
        :workflow_state => "Workflow State",
        :created_by => 1,
        :environment => nil,
        :role => nil,
        :changelist => "MyText"
      ),
      stub_model(Refresh,
        :workflow_state => "Workflow State",
        :created_by => 1,
        :environment => nil,
        :role => nil,
        :changelist => "MyText"
      )
    ])
  end

  it "renders a list of refreshes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Workflow State".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
