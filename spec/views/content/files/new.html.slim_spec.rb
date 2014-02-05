require 'spec_helper'

describe "content/files/new" do
  before(:each) do
    assign(:content_file, stub_model(Content::File,
      :file => "MyString"
    ).as_new_record)
  end

  it "renders new content_file form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_files_path, "post" do
      assert_select "input#content_file_file[name=?]", "content_file[file]"
    end
  end
end
