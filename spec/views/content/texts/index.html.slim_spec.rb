require 'spec_helper'

describe "content/texts/index" do
  before(:each) do
    assign(:content_texts, [
      stub_model(Content::Text,
        :text => "MyText"
      ),
      stub_model(Content::Text,
        :text => "MyText"
      )
    ])
  end

  it "renders a list of content/texts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
