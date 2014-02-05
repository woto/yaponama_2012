require "spec_helper"

describe Content::TextsController do
  describe "routing" do

    it "routes to #index" do
      get("/content/texts").should route_to("content/texts#index")
    end

    it "routes to #new" do
      get("/content/texts/new").should route_to("content/texts#new")
    end

    it "routes to #show" do
      get("/content/texts/1").should route_to("content/texts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/content/texts/1/edit").should route_to("content/texts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/content/texts").should route_to("content/texts#create")
    end

    it "routes to #update" do
      put("/content/texts/1").should route_to("content/texts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/content/texts/1").should route_to("content/texts#destroy", :id => "1")
    end

  end
end
