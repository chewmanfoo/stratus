require "spec_helper"

describe RetriesController do
  describe "routing" do

    it "routes to #index" do
      get("/retries").should route_to("retries#index")
    end

    it "routes to #new" do
      get("/retries/new").should route_to("retries#new")
    end

    it "routes to #show" do
      get("/retries/1").should route_to("retries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/retries/1/edit").should route_to("retries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/retries").should route_to("retries#create")
    end

    it "routes to #update" do
      put("/retries/1").should route_to("retries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/retries/1").should route_to("retries#destroy", :id => "1")
    end

  end
end
