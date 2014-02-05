require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe RspecTestsController do

  # This should return the minimal set of attributes required to create a valid
  # RspecTest. As you add validations to RspecTest, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RspecTestsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all rspec_tests as @rspec_tests" do
      rspec_test = RspecTest.create! valid_attributes
      get :index, {}, valid_session
      assigns(:rspec_tests).should eq([rspec_test])
    end
  end

  describe "GET show" do
    it "assigns the requested rspec_test as @rspec_test" do
      rspec_test = RspecTest.create! valid_attributes
      get :show, {:id => rspec_test.to_param}, valid_session
      assigns(:rspec_test).should eq(rspec_test)
    end
  end

  describe "GET new" do
    it "assigns a new rspec_test as @rspec_test" do
      get :new, {}, valid_session
      assigns(:rspec_test).should be_a_new(RspecTest)
    end
  end

  describe "GET edit" do
    it "assigns the requested rspec_test as @rspec_test" do
      rspec_test = RspecTest.create! valid_attributes
      get :edit, {:id => rspec_test.to_param}, valid_session
      assigns(:rspec_test).should eq(rspec_test)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new RspecTest" do
        expect {
          post :create, {:rspec_test => valid_attributes}, valid_session
        }.to change(RspecTest, :count).by(1)
      end

      it "assigns a newly created rspec_test as @rspec_test" do
        post :create, {:rspec_test => valid_attributes}, valid_session
        assigns(:rspec_test).should be_a(RspecTest)
        assigns(:rspec_test).should be_persisted
      end

      it "redirects to the created rspec_test" do
        post :create, {:rspec_test => valid_attributes}, valid_session
        response.should redirect_to(RspecTest.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rspec_test as @rspec_test" do
        # Trigger the behavior that occurs when invalid params are submitted
        RspecTest.any_instance.stub(:save).and_return(false)
        post :create, {:rspec_test => { "name" => "invalid value" }}, valid_session
        assigns(:rspec_test).should be_a_new(RspecTest)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        RspecTest.any_instance.stub(:save).and_return(false)
        post :create, {:rspec_test => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rspec_test" do
        rspec_test = RspecTest.create! valid_attributes
        # Assuming there are no other rspec_tests in the database, this
        # specifies that the RspecTest created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        RspecTest.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => rspec_test.to_param, :rspec_test => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested rspec_test as @rspec_test" do
        rspec_test = RspecTest.create! valid_attributes
        put :update, {:id => rspec_test.to_param, :rspec_test => valid_attributes}, valid_session
        assigns(:rspec_test).should eq(rspec_test)
      end

      it "redirects to the rspec_test" do
        rspec_test = RspecTest.create! valid_attributes
        put :update, {:id => rspec_test.to_param, :rspec_test => valid_attributes}, valid_session
        response.should redirect_to(rspec_test)
      end
    end

    describe "with invalid params" do
      it "assigns the rspec_test as @rspec_test" do
        rspec_test = RspecTest.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RspecTest.any_instance.stub(:save).and_return(false)
        put :update, {:id => rspec_test.to_param, :rspec_test => { "name" => "invalid value" }}, valid_session
        assigns(:rspec_test).should eq(rspec_test)
      end

      it "re-renders the 'edit' template" do
        rspec_test = RspecTest.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RspecTest.any_instance.stub(:save).and_return(false)
        put :update, {:id => rspec_test.to_param, :rspec_test => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested rspec_test" do
      rspec_test = RspecTest.create! valid_attributes
      expect {
        delete :destroy, {:id => rspec_test.to_param}, valid_session
      }.to change(RspecTest, :count).by(-1)
    end

    it "redirects to the rspec_tests list" do
      rspec_test = RspecTest.create! valid_attributes
      delete :destroy, {:id => rspec_test.to_param}, valid_session
      response.should redirect_to(rspec_tests_url)
    end
  end

end
