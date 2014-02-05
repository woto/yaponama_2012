require 'spec_helper'

describe "content/links/edit" do
  before(:each) do
    @content_link = assign(:content_link, stub_model(Content::Link,
      :url => "MyString",
      :title => "MyString",
      :target => "MyString"
    ))
  end

  it "renders the edit content_link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_link_path(@content_link), "post" do
      assert_select "input#content_link_url[name=?]", "content_link[url]"
      assert_select "input#content_link_title[name=?]", "content_link[title]"
      assert_select "input#content_link_target[name=?]", "content_link[target]"
    end
  end
end
