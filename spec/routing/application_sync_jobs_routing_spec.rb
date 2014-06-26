require "spec_helper"

describe ApplicationSyncJobsController do
  describe "routing" do

    it "routes to #index" do
      get("/application_sync_jobs").should route_to("application_sync_jobs#index")
    end

    it "routes to #new" do
      get("/application_sync_jobs/new").should route_to("application_sync_jobs#new")
    end

    it "routes to #show" do
      get("/application_sync_jobs/1").should route_to("application_sync_jobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/application_sync_jobs/1/edit").should route_to("application_sync_jobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/application_sync_jobs").should route_to("application_sync_jobs#create")
    end

    it "routes to #update" do
      put("/application_sync_jobs/1").should route_to("application_sync_jobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/application_sync_jobs/1").should route_to("application_sync_jobs#destroy", :id => "1")
    end

  end
end
