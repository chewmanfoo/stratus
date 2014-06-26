require "spec_helper"

describe ServerSyncJobsController do
  describe "routing" do

    it "routes to #index" do
      get("/server_sync_jobs").should route_to("server_sync_jobs#index")
    end

    it "routes to #new" do
      get("/server_sync_jobs/new").should route_to("server_sync_jobs#new")
    end

    it "routes to #show" do
      get("/server_sync_jobs/1").should route_to("server_sync_jobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/server_sync_jobs/1/edit").should route_to("server_sync_jobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/server_sync_jobs").should route_to("server_sync_jobs#create")
    end

    it "routes to #update" do
      put("/server_sync_jobs/1").should route_to("server_sync_jobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/server_sync_jobs/1").should route_to("server_sync_jobs#destroy", :id => "1")
    end

  end
end
