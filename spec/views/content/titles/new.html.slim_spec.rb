require 'spec_helper'

describe "content/titles/new" do
  before(:each) do
    assign(:content_title, stub_model(Content::Title,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new content_title form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_titles_path, "post" do
      assert_select "input#content_title_title[name=?]", "content_title[title]"
    end
  end
end
