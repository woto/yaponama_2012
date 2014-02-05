require 'spec_helper'

describe "content/files/show" do
  before(:each) do
    @content_file = assign(:content_file, stub_model(Content::File,
      :file => "File"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/File/)
  end
end
