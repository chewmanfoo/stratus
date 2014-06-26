require "spec_helper"

describe DeploymentRequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/deployment_requests").should route_to("deployment_requests#index")
    end

    it "routes to #new" do
      get("/deployment_requests/new").should route_to("deployment_requests#new")
    end

    it "routes to #show" do
      get("/deployment_requests/1").should route_to("deployment_requests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/deployment_requests/1/edit").should route_to("deployment_requests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/deployment_requests").should route_to("deployment_requests#create")
    end

    it "routes to #update" do
      put("/deployment_requests/1").should route_to("deployment_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/deployment_requests/1").should route_to("deployment_requests#destroy", :id => "1")
    end

  end
end
