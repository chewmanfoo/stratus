require "spec_helper"

describe AuthKeysController do
  describe "routing" do

    it "routes to #index" do
      get("/auth_keys").should route_to("auth_keys#index")
    end

    it "routes to #new" do
      get("/auth_keys/new").should route_to("auth_keys#new")
    end

    it "routes to #show" do
      get("/auth_keys/1").should route_to("auth_keys#show", :id => "1")
    end

    it "routes to #edit" do
      get("/auth_keys/1/edit").should route_to("auth_keys#edit", :id => "1")
    end

    it "routes to #create" do
      post("/auth_keys").should route_to("auth_keys#create")
    end

    it "routes to #update" do
      put("/auth_keys/1").should route_to("auth_keys#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/auth_keys/1").should route_to("auth_keys#destroy", :id => "1")
    end

  end
end
