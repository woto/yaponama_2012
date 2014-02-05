require "spec_helper"

describe Content::GroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/content/groups").should route_to("content/groups#index")
    end

    it "routes to #new" do
      get("/content/groups/new").should route_to("content/groups#new")
    end

    it "routes to #show" do
      get("/content/groups/1").should route_to("content/groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/content/groups/1/edit").should route_to("content/groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/content/groups").should route_to("content/groups#create")
    end

    it "routes to #update" do
      put("/content/groups/1").should route_to("content/groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/content/groups/1").should route_to("content/groups#destroy", :id => "1")
    end

  end
end
