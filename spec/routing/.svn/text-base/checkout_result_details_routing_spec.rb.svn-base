require "spec_helper"

describe CheckoutResultDetailsController do
  describe "routing" do

    it "routes to #index" do
      get("/checkout_result_details").should route_to("checkout_result_details#index")
    end

    it "routes to #new" do
      get("/checkout_result_details/new").should route_to("checkout_result_details#new")
    end

    it "routes to #show" do
      get("/checkout_result_details/1").should route_to("checkout_result_details#show", :id => "1")
    end

    it "routes to #edit" do
      get("/checkout_result_details/1/edit").should route_to("checkout_result_details#edit", :id => "1")
    end

    it "routes to #create" do
      post("/checkout_result_details").should route_to("checkout_result_details#create")
    end

    it "routes to #update" do
      put("/checkout_result_details/1").should route_to("checkout_result_details#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/checkout_result_details/1").should route_to("checkout_result_details#destroy", :id => "1")
    end

  end
end
