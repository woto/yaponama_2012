require 'spec_helper'

describe "content/groups/show" do
  before(:each) do
    @content_group = assign(:content_group, stub_model(Content::Group))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
