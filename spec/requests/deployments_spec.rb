require 'spec_helper'

describe "Deployments" do
  let(:deployment) { FactoryGirl.create(:deployment) }

  describe "Deployment Approvals" do
    it "updates a deployment's workflow_state when the deployment is approved" do

      visit welcome_index_path
      click_link "approve"

      
    end
  end
end
