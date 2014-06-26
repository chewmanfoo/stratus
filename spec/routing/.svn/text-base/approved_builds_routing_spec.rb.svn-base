require "spec_helper"

describe ApprovedBuildsController do
  describe "routing" do

    it "routes to #index" do
      get("/approved_builds").should route_to("approved_builds#index")
    end

    it "routes to #new" do
      get("/approved_builds/new").should route_to("approved_builds#new")
    end

    it "routes to #show" do
      get("/approved_builds/1").should route_to("approved_builds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/approved_builds/1/edit").should route_to("approved_builds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/approved_builds").should route_to("approved_builds#create")
    end

    it "routes to #update" do
      put("/approved_builds/1").should route_to("approved_builds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/approved_builds/1").should route_to("approved_builds#destroy", :id => "1")
    end

  end
end
