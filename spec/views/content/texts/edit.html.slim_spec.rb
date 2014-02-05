require 'spec_helper'

describe "content/texts/edit" do
  before(:each) do
    @content_text = assign(:content_text, stub_model(Content::Text,
      :text => "MyText"
    ))
  end

  it "renders the edit content_text form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_text_path(@content_text), "post" do
      assert_select "textarea#content_text_text[name=?]", "content_text[text]"
    end
  end
end
