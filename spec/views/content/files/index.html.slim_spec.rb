require 'spec_helper'

describe "content/files/index" do
  before(:each) do
    assign(:content_files, [
      stub_model(Content::File,
        :file => "File"
      ),
      stub_model(Content::File,
        :file => "File"
      )
    ])
  end

  it "renders a list of content/files" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "File".to_s, :count => 2
  end
end
