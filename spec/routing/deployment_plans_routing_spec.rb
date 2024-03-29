require "spec_helper"

describe DeploymentPlansController do
  describe "routing" do

    it "routes to #index" do
      get("/deployment_plans").should route_to("deployment_plans#index")
    end

    it "routes to #new" do
      get("/deployment_plans/new").should route_to("deployment_plans#new")
    end

    it "routes to #show" do
      get("/deployment_plans/1").should route_to("deployment_plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deployment_plans/1/edit").should route_to("deployment_plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deployment_plans").should route_to("deployment_plans#create")
    end

    it "routes to #update" do
      put("/deployment_plans/1").should route_to("deployment_plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deployment_plans/1").should route_to("deployment_plans#destroy", :id => "1")
    end

  end
end
