require 'spec_helper'

describe "EsrWorks" do
  describe "GET /esr_works" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get esr_works_path
      response.status.should be(200)
    end
  end
end
