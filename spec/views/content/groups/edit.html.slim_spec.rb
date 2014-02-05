require 'spec_helper'

describe "content/groups/edit" do
  before(:each) do
    @content_group = assign(:content_group, stub_model(Content::Group))
  end

  it "renders the edit content_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_group_path(@content_group), "post" do
    end
  end
end
