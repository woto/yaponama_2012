require 'spec_helper'

describe "content/titles/index" do
  before(:each) do
    assign(:content_titles, [
      stub_model(Content::Title,
        :title => "Title"
      ),
      stub_model(Content::Title,
        :title => "Title"
      )
    ])
  end

  it "renders a list of content/titles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
