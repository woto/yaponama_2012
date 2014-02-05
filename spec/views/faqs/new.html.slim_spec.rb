require 'spec_helper'

describe "faqs/new" do
  before(:each) do
    assign(:faq, stub_model(Faq,
      :question => "MyText",
      :answer => "MyText"
    ).as_new_record)
  end

  it "renders new faq form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", faqs_path, "post" do
      assert_select "textarea#faq_question[name=?]", "faq[question]"
      assert_select "textarea#faq_answer[name=?]", "faq[answer]"
    end
  end
end
