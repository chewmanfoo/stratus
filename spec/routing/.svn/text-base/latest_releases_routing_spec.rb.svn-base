require "spec_helper"

describe LatestReleasesController do
  describe "routing" do

    it "routes to #index" do
      get("/latest_releases").should route_to("latest_releases#index")
    end

    it "routes to #new" do
      get("/latest_releases/new").should route_to("latest_releases#new")
    end

    it "routes to #show" do
      get("/latest_releases/1").should route_to("latest_releases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/latest_releases/1/edit").should route_to("latest_releases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/latest_releases").should route_to("latest_releases#create")
    end

    it "routes to #update" do
      put("/latest_releases/1").should route_to("latest_releases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/latest_releases/1").should route_to("latest_releases#destroy", :id => "1")
    end

  end
end
