require "spec_helper"

describe Content::PartsController do
  describe "routing" do

    it "routes to #index" do
      get("/content/parts").should route_to("content/parts#index")
    end

    it "routes to #new" do
      get("/content/parts/new").should route_to("content/parts#new")
    end

    it "routes to #show" do
      get("/content/parts/1").should route_to("content/parts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/content/parts/1/edit").should route_to("content/parts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/content/parts").should route_to("content/parts#create")
    end

    it "routes to #update" do
      put("/content/parts/1").should route_to("content/parts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/content/parts/1").should route_to("content/parts#destroy", :id => "1")
    end

  end
end
