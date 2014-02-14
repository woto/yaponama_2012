require 'spec_helper'

describe "spare_catalogs/new" do
  before(:each) do
    assign(:spare_catalog, stub_model(SpareCatalog,
      :title => "MyString",
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new spare_catalog form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", spare_catalogs_path, "post" do
      assert_select "input#spare_catalog_title[name=?]", "spare_catalog[title]"
      assert_select "textarea#spare_catalog_text[name=?]", "spare_catalog[text]"
    end
  end
end
