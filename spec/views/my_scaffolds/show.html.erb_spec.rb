require 'spec_helper'

describe "my_scaffolds/show" do
  before(:each) do
    @my_scaffold = assign(:my_scaffold, stub_model(MyScaffold,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
