require 'spec_helper'

describe "rspec_tests/show" do
  before(:each) do
    @rspec_test = assign(:rspec_test, stub_model(RspecTest,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
