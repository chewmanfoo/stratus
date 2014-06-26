require 'spec_helper'

describe "latest_releases/new" do
  before(:each) do
    assign(:latest_release, stub_model(LatestRelease,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new latest_release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => latest_releases_path, :method => "post" do
      assert_select "input#latest_release_name", :name => "latest_release[name]"
    end
  end
end
