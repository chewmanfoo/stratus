require "spec_helper"

describe CheckoutResultsController do
  describe "routing" do

    it "routes to #index" do
      get("/checkout_results").should route_to("checkout_results#index")
    end

    it "routes to #new" do
      get("/checkout_results/new").should route_to("checkout_results#new")
    end

    it "routes to #show" do
      get("/checkout_results/1").should route_to("checkout_results#show", :id => "1")
    end

    it "routes to #edit" do
      get("/checkout_results/1/edit").should route_to("checkout_results#edit", :id => "1")
    end

    it "routes to #create" do
      post("/checkout_results").should route_to("checkout_results#create")
    end

    it "routes to #update" do
      put("/checkout_results/1").should route_to("checkout_results#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/checkout_results/1").should route_to("checkout_results#destroy", :id => "1")
    end

  end
end
