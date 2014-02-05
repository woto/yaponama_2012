require 'spec_helper'

describe "content/parts/index" do
  before(:each) do
    assign(:content_parts, [
      stub_model(Content::Part,
        :group => nil,
        :partable => nil,
        :order => 1
      ),
      stub_model(Content::Part,
        :group => nil,
        :partable => nil,
        :order => 1
      )
    ])
  end

  it "renders a list of content/parts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
