require 'spec_helper'

describe "faqs/edit" do
  before(:each) do
    @faq = assign(:faq, stub_model(Faq,
      :question => "MyText",
      :answer => "MyText"
    ))
  end

  it "renders the edit faq form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", faq_path(@faq), "post" do
      assert_select "textarea#faq_question[name=?]", "faq[question]"
      assert_select "textarea#faq_answer[name=?]", "faq[answer]"
    end
  end
end
