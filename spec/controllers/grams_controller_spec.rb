require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should show the page successfully" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should show the new form successfully" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do
    it "should post the user's gram (creating gram in our database) and send to gram's show page" do
      post :create, gram: {message: 'Hello!'}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
    end

    it "should properly show validation errors" do
      post :create, gram: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq 0
    end
  end

end