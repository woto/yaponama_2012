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

describe Content::GroupsController do

  # This should return the minimal set of attributes required to create a valid
  # Content::Group. As you add validations to Content::Group, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Content::GroupsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all content_groups as @content_groups" do
      group = Content::Group.create! valid_attributes
      get :index, {}, valid_session
      assigns(:content_groups).should eq([group])
    end
  end

  describe "GET show" do
    it "assigns the requested content_group as @content_group" do
      group = Content::Group.create! valid_attributes
      get :show, {:id => group.to_param}, valid_session
      assigns(:content_group).should eq(group)
    end
  end

  describe "GET new" do
    it "assigns a new content_group as @content_group" do
      get :new, {}, valid_session
      assigns(:content_group).should be_a_new(Content::Group)
    end
  end

  describe "GET edit" do
    it "assigns the requested content_group as @content_group" do
      group = Content::Group.create! valid_attributes
      get :edit, {:id => group.to_param}, valid_session
      assigns(:content_group).should eq(group)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Content::Group" do
        expect {
          post :create, {:content_group => valid_attributes}, valid_session
        }.to change(Content::Group, :count).by(1)
      end

      it "assigns a newly created content_group as @content_group" do
        post :create, {:content_group => valid_attributes}, valid_session
        assigns(:content_group).should be_a(Content::Group)
        assigns(:content_group).should be_persisted
      end

      it "redirects to the created content_group" do
        post :create, {:content_group => valid_attributes}, valid_session
        response.should redirect_to(Content::Group.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved content_group as @content_group" do
        # Trigger the behavior that occurs when invalid params are submitted
        Content::Group.any_instance.stub(:save).and_return(false)
        post :create, {:content_group => {  }}, valid_session
        assigns(:content_group).should be_a_new(Content::Group)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Content::Group.any_instance.stub(:save).and_return(false)
        post :create, {:content_group => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested content_group" do
        group = Content::Group.create! valid_attributes
        # Assuming there are no other content_groups in the database, this
        # specifies that the Content::Group created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Content::Group.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => group.to_param, :content_group => { "these" => "params" }}, valid_session
      end

      it "assigns the requested content_group as @content_group" do
        group = Content::Group.create! valid_attributes
        put :update, {:id => group.to_param, :content_group => valid_attributes}, valid_session
        assigns(:content_group).should eq(group)
      end

      it "redirects to the content_group" do
        group = Content::Group.create! valid_attributes
        put :update, {:id => group.to_param, :content_group => valid_attributes}, valid_session
        response.should redirect_to(group)
      end
    end

    describe "with invalid params" do
      it "assigns the content_group as @content_group" do
        group = Content::Group.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Content::Group.any_instance.stub(:save).and_return(false)
        put :update, {:id => group.to_param, :content_group => {  }}, valid_session
        assigns(:content_group).should eq(group)
      end

      it "re-renders the 'edit' template" do
        group = Content::Group.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Content::Group.any_instance.stub(:save).and_return(false)
        put :update, {:id => group.to_param, :content_group => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested content_group" do
      group = Content::Group.create! valid_attributes
      expect {
        delete :destroy, {:id => group.to_param}, valid_session
      }.to change(Content::Group, :count).by(-1)
    end

    it "redirects to the content_groups list" do
      group = Content::Group.create! valid_attributes
      delete :destroy, {:id => group.to_param}, valid_session
      response.should redirect_to(content_groups_url)
    end
  end

end