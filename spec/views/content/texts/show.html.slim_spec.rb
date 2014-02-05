require 'spec_helper'

describe "content/texts/show" do
  before(:each) do
    @content_text = assign(:content_text, stub_model(Content::Text,
      :text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
