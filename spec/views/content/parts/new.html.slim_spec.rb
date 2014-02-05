require 'spec_helper'

describe "content/parts/new" do
  before(:each) do
    assign(:content_part, stub_model(Content::Part,
      :group => nil,
      :partable => nil,
      :order => 1
    ).as_new_record)
  end

  it "renders new content_part form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_parts_path, "post" do
      assert_select "input#content_part_group[name=?]", "content_part[group]"
      assert_select "input#content_part_partable[name=?]", "content_part[partable]"
      assert_select "input#content_part_order[name=?]", "content_part[order]"
    end
  end
end
