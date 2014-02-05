require 'spec_helper'

describe "content/titles/show" do
  before(:each) do
    @content_title = assign(:content_title, stub_model(Content::Title,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
