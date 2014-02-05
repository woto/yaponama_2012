require 'spec_helper'

describe "rspec_tests/edit" do
  before(:each) do
    @rspec_test = assign(:rspec_test, stub_model(RspecTest,
      :name => "MyString"
    ))
  end

  it "renders the edit rspec_test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rspec_test_path(@rspec_test), "post" do
      assert_select "input#rspec_test_name[name=?]", "rspec_test[name]"
    end
  end
end
