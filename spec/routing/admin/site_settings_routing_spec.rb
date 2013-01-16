require "spec_helper"

describe Admin::SiteSettingsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/site_settings").should route_to("admin/site_settings#index")
    end

    it "routes to #new" do
      get("/admin/site_settings/new").should route_to("admin/site_settings#new")
    end

    it "routes to #show" do
      get("/admin/site_settings/1").should route_to("admin/site_settings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/site_settings/1/edit").should route_to("admin/site_settings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/site_settings").should route_to("admin/site_settings#create")
    end

    it "routes to #update" do
      put("/admin/site_settings/1").should route_to("admin/site_settings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/site_settings/1").should route_to("admin/site_settings#destroy", :id => "1")
    end

  end
end
