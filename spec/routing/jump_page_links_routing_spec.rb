require "spec_helper"

describe JumpPageLinksController do
  describe "routing" do

    it "routes to #index" do
      get("/jump_page_links").should route_to("jump_page_links#index")
    end

    it "routes to #new" do
      get("/jump_page_links/new").should route_to("jump_page_links#new")
    end

    it "routes to #show" do
      get("/jump_page_links/1").should route_to("jump_page_links#show", :id => "1")
    end

    it "routes to #edit" do
      get("/jump_page_links/1/edit").should route_to("jump_page_links#edit", :id => "1")
    end

    it "routes to #create" do
      post("/jump_page_links").should route_to("jump_page_links#create")
    end

    it "routes to #update" do
      put("/jump_page_links/1").should route_to("jump_page_links#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/jump_page_links/1").should route_to("jump_page_links#destroy", :id => "1")
    end

  end
end
