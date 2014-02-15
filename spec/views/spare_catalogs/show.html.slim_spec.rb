require 'spec_helper'

describe "spare_catalogs/show" do
  before(:each) do
    @spare_catalog = assign(:spare_catalog, stub_model(SpareCatalog,
      :title => "Title",
      :text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
