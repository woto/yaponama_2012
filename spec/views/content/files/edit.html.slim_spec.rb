require 'spec_helper'

describe "content/files/edit" do
  before(:each) do
    @content_file = assign(:content_file, stub_model(Content::File,
      :file => "MyString"
    ))
  end

  it "renders the edit content_file form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_file_path(@content_file), "post" do
      assert_select "input#content_file_file[name=?]", "content_file[file]"
    end
  end
end
