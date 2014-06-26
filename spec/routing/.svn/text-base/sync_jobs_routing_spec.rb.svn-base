require "spec_helper"

describe SyncJobsController do
  describe "routing" do

    it "routes to #index" do
      get("/sync_jobs").should route_to("sync_jobs#index")
    end

    it "routes to #new" do
      get("/sync_jobs/new").should route_to("sync_jobs#new")
    end

    it "routes to #show" do
      get("/sync_jobs/1").should route_to("sync_jobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sync_jobs/1/edit").should route_to("sync_jobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sync_jobs").should route_to("sync_jobs#create")
    end

    it "routes to #update" do
      put("/sync_jobs/1").should route_to("sync_jobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sync_jobs/1").should route_to("sync_jobs#destroy", :id => "1")
    end

  end
end
