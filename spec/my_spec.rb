## encoding: utf-8
##
#require 'spec_helper'
#
#describe "some" do
#
#  fixtures :users, :products
#
#  #it "should render index template on index call when logged in" do
#  #  #users(:c1).should be_valid
#  #  users(:user1).should have(1).error_on(:order_rule)
#  #end
#
#  #it "should render index template on index call when logged in" do
#  #  #users(:c1).should be_valid
#  #  users(:user2).should have(1).error_on(:discount)
#  #end
#
#  it "Статус нового созданного продукта должен быть incart" do
#    products(:p1).should be_valid
#    products(:p3).should be_valid
#
#    p4 = products(:p4)
#    p4.valid?
#    p4.should be_valid
#    p4.status.should eq("incart")
#  end
#end
