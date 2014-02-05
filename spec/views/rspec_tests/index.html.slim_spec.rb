require 'spec_helper'

describe "rspec_tests/index" do
  before(:each) do
    assign(:rspec_tests, [
      stub_model(RspecTest,
        :name => "Name"
      ),
      stub_model(RspecTest,
        :name => "Name"
      )
    ])
  end

  it "renders a list of rspec_tests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
