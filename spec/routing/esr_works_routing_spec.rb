require "spec_helper"

describe EsrWorksController do
  describe "routing" do

    it "routes to #index" do
      get("/esr_works").should route_to("esr_works#index")
    end

    it "routes to #new" do
      get("/esr_works/new").should route_to("esr_works#new")
    end

    it "routes to #show" do
      get("/esr_works/1").should route_to("esr_works#show", :id => "1")
    end

    it "routes to #edit" do
      get("/esr_works/1/edit").should route_to("esr_works#edit", :id => "1")
    end

    it "routes to #create" do
      post("/esr_works").should route_to("esr_works#create")
    end

    it "routes to #update" do
      put("/esr_works/1").should route_to("esr_works#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/esr_works/1").should route_to("esr_works#destroy", :id => "1")
    end

  end
end
