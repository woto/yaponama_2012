require 'spec_helper'

describe "payments/new" do
  before(:each) do
    assign(:payment, stub_model(Payment,
      :amount => 1,
      :somebody => nil,
      :profile => nil,
      :postal_address => nil,
      :company => nil
    ).as_new_record)
  end

  it "renders new payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", payments_path, "post" do
      assert_select "input#payment_amount[name=?]", "payment[amount]"
      assert_select "input#payment_somebody[name=?]", "payment[somebody]"
      assert_select "input#payment_profile[name=?]", "payment[profile]"
      assert_select "input#payment_postal_address[name=?]", "payment[postal_address]"
      assert_select "input#payment_company[name=?]", "payment[company]"
    end
  end
end
