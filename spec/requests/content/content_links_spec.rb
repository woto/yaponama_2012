require 'spec_helper'

describe "Content::Links" do
  describe "GET /content_links" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get content_links_path
      response.status.should be(200)
    end
  end
end