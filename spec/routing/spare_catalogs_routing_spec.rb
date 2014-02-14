require "spec_helper"

describe SpareCatalogsController do
  describe "routing" do

    it "routes to #index" do
      get("/spare_catalogs").should route_to("spare_catalogs#index")
    end

    it "routes to #new" do
      get("/spare_catalogs/new").should route_to("spare_catalogs#new")
    end

    it "routes to #show" do
      get("/spare_catalogs/1").should route_to("spare_catalogs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/spare_catalogs/1/edit").should route_to("spare_catalogs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/spare_catalogs").should route_to("spare_catalogs#create")
    end

    it "routes to #update" do
      put("/spare_catalogs/1").should route_to("spare_catalogs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/spare_catalogs/1").should route_to("spare_catalogs#destroy", :id => "1")
    end

  end
end
