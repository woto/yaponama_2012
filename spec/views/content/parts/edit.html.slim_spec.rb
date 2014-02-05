require 'spec_helper'

describe "content/parts/edit" do
  before(:each) do
    @content_part = assign(:content_part, stub_model(Content::Part,
      :group => nil,
      :partable => nil,
      :order => 1
    ))
  end

  it "renders the edit content_part form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_part_path(@content_part), "post" do
      assert_select "input#content_part_group[name=?]", "content_part[group]"
      assert_select "input#content_part_partable[name=?]", "content_part[partable]"
      assert_select "input#content_part_order[name=?]", "content_part[order]"
    end
  end
end
