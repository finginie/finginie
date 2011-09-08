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

describe FixedIncomesController do

  let (:fixed_income) { create :fixed_income }
  let (:valid_attributes) { attributes_for :fixed_income }

  describe "GET index" do
    it "assigns all fixed_incomes as @fixed_incomes" do
      get :index
      assigns(:fixed_incomes).should eq([fixed_income])
    end
  end

  describe "GET show" do
    it "assigns the requested fixed_income as @fixed_income" do
      get :show, :id => fixed_income.id.to_s
      assigns(:fixed_income).should eq(fixed_income)
    end
  end

  describe "GET new" do
    it "assigns a new fixed_income as @fixed_income" do
      get :new
      assigns(:fixed_income).should be_a_new(FixedIncome)
    end
  end

  describe "GET edit" do
    it "assigns the requested fixed_income as @fixed_income" do
      get :edit, :id => fixed_income.id.to_s
      assigns(:fixed_income).should eq(fixed_income)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new FixedIncome" do
        expect {
          post :create, :fixed_income => valid_attributes
        }.to change(FixedIncome, :count).by(1)
      end

      it "assigns a newly created fixed_income as @fixed_income" do
        post :create, :fixed_income => valid_attributes
        assigns(:fixed_income).should be_a(FixedIncome)
        assigns(:fixed_income).should be_persisted
      end

      it "redirects to the created fixed_income" do
        post :create, :fixed_income => valid_attributes
        response.should redirect_to(FixedIncome.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved fixed_income as @fixed_income" do
        # Trigger the behavior that occurs when invalid params are submitted
        FixedIncome.any_instance.stub(:save).and_return(false)
        post :create, :fixed_income => {}
        assigns(:fixed_income).should be_a_new(FixedIncome)
      end

      pending "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        FixedIncome.any_instance.stub(:save).and_return(false)
        post :create, :fixed_income => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested fixed_income" do
        # Assuming there are no other fixed_incomes in the database, this
        # specifies that the FixedIncome created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        FixedIncome.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => fixed_income.id, :fixed_income => {'these' => 'params'}
      end

      it "assigns the requested fixed_income as @fixed_income" do
        put :update, :id => fixed_income.id, :fixed_income => valid_attributes
        assigns(:fixed_income).should eq(fixed_income)
      end

      it "redirects to the fixed_income" do
        put :update, :id => fixed_income.id, :fixed_income => valid_attributes
        response.should redirect_to(fixed_income)
      end
    end

    describe "with invalid params" do
      it "assigns the fixed_income as @fixed_income" do
        # Trigger the behavior that occurs when invalid params are submitted
        FixedIncome.any_instance.stub(:save).and_return(false)
        put :update, :id => fixed_income.id.to_s, :fixed_income => {}
        assigns(:fixed_income).should eq(fixed_income)
      end

      pending "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        FixedIncome.any_instance.stub(:save).and_return(false)
        put :update, :id => fixed_income.id.to_s, :fixed_income => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested fixed_income" do
      fixed_income
      expect {
        delete :destroy, :id => fixed_income.id.to_s
      }.to change(FixedIncome, :count).by(-1)
    end

    it "redirects to the fixed_incomes list" do
      delete :destroy, :id => fixed_income.id.to_s
      response.should redirect_to(fixed_incomes_url)
    end
  end

end
