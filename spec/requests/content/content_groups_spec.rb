require 'spec_helper'

describe "Content::Groups" do
  describe "GET /content_groups" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get content_groups_path
      response.status.should be(200)
    end
  end
end
