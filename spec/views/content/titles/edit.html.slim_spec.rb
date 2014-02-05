require 'spec_helper'

describe "content/titles/edit" do
  before(:each) do
    @content_title = assign(:content_title, stub_model(Content::Title,
      :title => "MyString"
    ))
  end

  it "renders the edit content_title form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_title_path(@content_title), "post" do
      assert_select "input#content_title_title[name=?]", "content_title[title]"
    end
  end
end
