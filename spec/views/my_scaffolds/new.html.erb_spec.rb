require 'spec_helper'

describe "my_scaffolds/new" do
  before(:each) do
    assign(:my_scaffold, stub_model(MyScaffold,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new my_scaffold form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => my_scaffolds_path, :method => "post" do
      assert_select "input#my_scaffold_name", :name => "my_scaffold[name]"
    end
  end
end
