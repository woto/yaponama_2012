require 'spec_helper'

describe "rspec_tests/new" do
  before(:each) do
    assign(:rspec_test, stub_model(RspecTest,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new rspec_test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rspec_tests_path, "post" do
      assert_select "input#rspec_test_name[name=?]", "rspec_test[name]"
    end
  end
end
