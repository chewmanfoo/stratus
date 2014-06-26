require "spec_helper"

describe EnvironmentSyncReportsController do
  describe "routing" do

    it "routes to #index" do
      get("/environment_sync_reports").should route_to("environment_sync_reports#index")
    end

    it "routes to #new" do
      get("/environment_sync_reports/new").should route_to("environment_sync_reports#new")
    end

    it "routes to #show" do
      get("/environment_sync_reports/1").should route_to("environment_sync_reports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/environment_sync_reports/1/edit").should route_to("environment_sync_reports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/environment_sync_reports").should route_to("environment_sync_reports#create")
    end

    it "routes to #update" do
      put("/environment_sync_reports/1").should route_to("environment_sync_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/environment_sync_reports/1").should route_to("environment_sync_reports#destroy", :id => "1")
    end

  end
end
