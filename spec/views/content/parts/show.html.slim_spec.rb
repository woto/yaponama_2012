require 'spec_helper'

describe "content/parts/show" do
  before(:each) do
    @content_part = assign(:content_part, stub_model(Content::Part,
      :group => nil,
      :partable => nil,
      :order => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
