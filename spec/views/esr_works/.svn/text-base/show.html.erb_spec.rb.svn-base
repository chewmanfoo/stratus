require 'spec_helper'

describe "esr_works/show" do
  before(:each) do
    @esr_work = assign(:esr_work, stub_model(EsrWork,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
