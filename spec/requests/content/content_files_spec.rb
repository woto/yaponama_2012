require 'spec_helper'

describe "Content::Files" do
  describe "GET /content_files" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get content_files_path
      response.status.should be(200)
    end
  end
end
