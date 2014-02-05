require 'spec_helper'

describe "content/links/show" do
  before(:each) do
    @content_link = assign(:content_link, stub_model(Content::Link,
      :url => "Url",
      :title => "Title",
      :target => "Target"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    rendered.should match(/Title/)
    rendered.should match(/Target/)
  end
end
