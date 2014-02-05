require "spec_helper"

describe RspecTestsController do
  describe "routing" do

    it "routes to #index" do
      get("/rspec_tests").should route_to("rspec_tests#index")
    end

    it "routes to #new" do
      get("/rspec_tests/new").should route_to("rspec_tests#new")
    end

    it "routes to #show" do
      get("/rspec_tests/1").should route_to("rspec_tests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/rspec_tests/1/edit").should route_to("rspec_tests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/rspec_tests").should route_to("rspec_tests#create")
    end

    it "routes to #update" do
      put("/rspec_tests/1").should route_to("rspec_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/rspec_tests/1").should route_to("rspec_tests#destroy", :id => "1")
    end

  end
end
