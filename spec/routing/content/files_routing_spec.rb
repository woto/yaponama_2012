require "spec_helper"

describe Content::FilesController do
  describe "routing" do

    it "routes to #index" do
      get("/content/files").should route_to("content/files#index")
    end

    it "routes to #new" do
      get("/content/files/new").should route_to("content/files#new")
    end

    it "routes to #show" do
      get("/content/files/1").should route_to("content/files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/content/files/1/edit").should route_to("content/files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/content/files").should route_to("content/files#create")
    end

    it "routes to #update" do
      put("/content/files/1").should route_to("content/files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/content/files/1").should route_to("content/files#destroy", :id => "1")
    end

  end
end
