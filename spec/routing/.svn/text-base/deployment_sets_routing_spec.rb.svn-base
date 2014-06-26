require "spec_helper"

describe DeploymentSetsController do
  describe "routing" do

    it "routes to #index" do
      get("/deployment_sets").should route_to("deployment_sets#index")
    end

    it "routes to #new" do
      get("/deployment_sets/new").should route_to("deployment_sets#new")
    end

    it "routes to #show" do
      get("/deployment_sets/1").should route_to("deployment_sets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deployment_sets/1/edit").should route_to("deployment_sets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deployment_sets").should route_to("deployment_sets#create")
    end

    it "routes to #update" do
      put("/deployment_sets/1").should route_to("deployment_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deployment_sets/1").should route_to("deployment_sets#destroy", :id => "1")
    end

  end
end
