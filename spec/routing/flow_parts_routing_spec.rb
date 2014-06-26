require "spec_helper"

describe FlowPartsController do
  describe "routing" do

    it "routes to #index" do
      get("/flow_parts").should route_to("flow_parts#index")
    end

    it "routes to #new" do
      get("/flow_parts/new").should route_to("flow_parts#new")
    end

    it "routes to #show" do
      get("/flow_parts/1").should route_to("flow_parts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/flow_parts/1/edit").should route_to("flow_parts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/flow_parts").should route_to("flow_parts#create")
    end

    it "routes to #update" do
      put("/flow_parts/1").should route_to("flow_parts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/flow_parts/1").should route_to("flow_parts#destroy", :id => "1")
    end

  end
end
