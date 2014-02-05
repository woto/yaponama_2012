require 'spec_helper'

describe "content/groups/new" do
  before(:each) do
    assign(:content_group, stub_model(Content::Group).as_new_record)
  end

  it "renders new content_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_groups_path, "post" do
    end
  end
end
