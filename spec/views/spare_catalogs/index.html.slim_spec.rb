require 'spec_helper'

describe "spare_catalogs/index" do
  before(:each) do
    assign(:spare_catalogs, [
      stub_model(SpareCatalog,
        :title => "Title",
        :text => "MyText"
      ),
      stub_model(SpareCatalog,
        :title => "Title",
        :text => "MyText"
      )
    ])
  end

  it "renders a list of spare_catalogs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
