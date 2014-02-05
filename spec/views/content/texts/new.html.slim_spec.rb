require 'spec_helper'

describe "content/texts/new" do
  before(:each) do
    assign(:content_text, stub_model(Content::Text,
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new content_text form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_texts_path, "post" do
      assert_select "textarea#content_text_text[name=?]", "content_text[text]"
    end
  end
end
