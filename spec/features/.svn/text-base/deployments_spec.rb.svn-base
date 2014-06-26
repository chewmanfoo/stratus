require 'spec_helper'

describe "Deployments" do
  let(:deployment) { FactoryGirl.create(:deployment) }

  describe "Deployment Approvals" do
    it "updates a deployment's workflow_state when the deployment is approved" do

#      visit welcome_index_path
      visit deployment_path(deployment) 
      puts "deployment is in #{deployment.environment_name}"
      click_link "approve!"

      
    end
  end
end
