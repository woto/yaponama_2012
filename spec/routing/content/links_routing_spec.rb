require "spec_helper"

describe Content::LinksController do
  describe "routing" do

    it "routes to #index" do
      get("/content/links").should route_to("content/links#index")
    end

    it "routes to #new" do
      get("/content/links/new").should route_to("content/links#new")
    end

    it "routes to #show" do
      get("/content/links/1").should route_to("content/links#show", :id => "1")
    end

    it "routes to #edit" do
      get("/content/links/1/edit").should route_to("content/links#edit", :id => "1")
    end

    it "routes to #create" do
      post("/content/links").should route_to("content/links#create")
    end

    it "routes to #update" do
      put("/content/links/1").should route_to("content/links#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/content/links/1").should route_to("content/links#destroy", :id => "1")
    end

  end
end
