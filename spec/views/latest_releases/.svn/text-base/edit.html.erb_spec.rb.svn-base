require 'spec_helper'

describe "latest_releases/edit" do
  before(:each) do
    @latest_release = assign(:latest_release, stub_model(LatestRelease,
      :name => "MyString"
    ))
  end

  it "renders the edit latest_release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => latest_releases_path(@latest_release), :method => "post" do
      assert_select "input#latest_release_name", :name => "latest_release[name]"
    end
  end
end
