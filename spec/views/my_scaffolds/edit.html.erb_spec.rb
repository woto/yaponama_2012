require 'spec_helper'

describe "my_scaffolds/edit" do
  before(:each) do
    @my_scaffold = assign(:my_scaffold, stub_model(MyScaffold,
      :name => "MyString"
    ))
  end

  it "renders the edit my_scaffold form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => my_scaffolds_path(@my_scaffold), :method => "post" do
      assert_select "input#my_scaffold_name", :name => "my_scaffold[name]"
    end
  end
end
