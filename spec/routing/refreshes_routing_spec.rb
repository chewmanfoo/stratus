require "spec_helper"

describe RefreshesController do
  describe "routing" do

    it "routes to #index" do
      get("/refreshes").should route_to("refreshes#index")
    end

    it "routes to #new" do
      get("/refreshes/new").should route_to("refreshes#new")
    end

    it "routes to #show" do
      get("/refreshes/1").should route_to("refreshes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/refreshes/1/edit").should route_to("refreshes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/refreshes").should route_to("refreshes#create")
    end

    it "routes to #update" do
      put("/refreshes/1").should route_to("refreshes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/refreshes/1").should route_to("refreshes#destroy", :id => "1")
    end

  end
end
