require 'spec_helper'

describe "my_scaffolds/index" do
  before(:each) do
    assign(:my_scaffolds, [
      stub_model(MyScaffold,
        :name => "Name"
      ),
      stub_model(MyScaffold,
        :name => "Name"
      )
    ])
  end

  it "renders a list of my_scaffolds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
