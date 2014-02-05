require "spec_helper"

describe Content::TitlesController do
  describe "routing" do

    it "routes to #index" do
      get("/content/titles").should route_to("content/titles#index")
    end

    it "routes to #new" do
      get("/content/titles/new").should route_to("content/titles#new")
    end

    it "routes to #show" do
      get("/content/titles/1").should route_to("content/titles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/content/titles/1/edit").should route_to("content/titles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/content/titles").should route_to("content/titles#create")
    end

    it "routes to #update" do
      put("/content/titles/1").should route_to("content/titles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/content/titles/1").should route_to("content/titles#destroy", :id => "1")
    end

  end
end
