require 'spec_helper'

describe "content/links/index" do
  before(:each) do
    assign(:content_links, [
      stub_model(Content::Link,
        :url => "Url",
        :title => "Title",
        :target => "Target"
      ),
      stub_model(Content::Link,
        :url => "Url",
        :title => "Title",
        :target => "Target"
      )
    ])
  end

  it "renders a list of content/links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Target".to_s, :count => 2
  end
end
