require 'spec_helper'

describe "chores/show" do
  before(:each) do
    @chore = assign(:chore, stub_model(Chore,
      :name => "Name",
      :command => "Command",
      :success => "Success",
      :fail => "Fail"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Command/)
    rendered.should match(/Success/)
    rendered.should match(/Fail/)
  end
end
