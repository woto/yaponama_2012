require 'spec_helper'

describe "spare_catalogs/edit" do
  before(:each) do
    @spare_catalog = assign(:spare_catalog, stub_model(SpareCatalog,
      :title => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit spare_catalog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spare_catalog_path(@spare_catalog), "post" do
      assert_select "input#spare_catalog_title[name=?]", "spare_catalog[title]"
      assert_select "textarea#spare_catalog_text[name=?]", "spare_catalog[text]"
    end
  end
end
