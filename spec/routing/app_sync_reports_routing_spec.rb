require "spec_helper"

describe AppSyncReportsController do
  describe "routing" do

    it "routes to #index" do
      get("/app_sync_reports").should route_to("app_sync_reports#index")
    end

    it "routes to #new" do
      get("/app_sync_reports/new").should route_to("app_sync_reports#new")
    end

    it "routes to #show" do
      get("/app_sync_reports/1").should route_to("app_sync_reports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/app_sync_reports/1/edit").should route_to("app_sync_reports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/app_sync_reports").should route_to("app_sync_reports#create")
    end

    it "routes to #update" do
      put("/app_sync_reports/1").should route_to("app_sync_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/app_sync_reports/1").should route_to("app_sync_reports#destroy", :id => "1")
    end

  end
end
