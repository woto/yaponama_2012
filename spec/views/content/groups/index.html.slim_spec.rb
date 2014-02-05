require 'spec_helper'

describe "content/groups/index" do
  before(:each) do
    assign(:content_groups, [
      stub_model(Content::Group),
      stub_model(Content::Group)
    ])
  end

  it "renders a list of content/groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
