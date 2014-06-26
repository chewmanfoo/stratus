require 'spec_helper'

describe "refreshes/show" do
  before(:each) do
    @refresh = assign(:refresh, stub_model(Refresh,
      :workflow_state => "Workflow State",
      :created_by => 1,
      :environment => nil,
      :role => nil,
      :changelist => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Workflow State/)
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
