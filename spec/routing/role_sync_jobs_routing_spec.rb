require "spec_helper"

describe RoleSyncJobsController do
  describe "routing" do

    it "routes to #index" do
      get("/role_sync_jobs").should route_to("role_sync_jobs#index")
    end

    it "routes to #new" do
      get("/role_sync_jobs/new").should route_to("role_sync_jobs#new")
    end

    it "routes to #show" do
      get("/role_sync_jobs/1").should route_to("role_sync_jobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/role_sync_jobs/1/edit").should route_to("role_sync_jobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/role_sync_jobs").should route_to("role_sync_jobs#create")
    end

    it "routes to #update" do
      put("/role_sync_jobs/1").should route_to("role_sync_jobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/role_sync_jobs/1").should route_to("role_sync_jobs#destroy", :id => "1")
    end

  end
end
