require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers
    before do
      @user = User.create(email: 'a@a', password: '123456')
      sign_in @user
    end
    
    describe 'GET /new' do
      it 'returns http success' do
        get '/recipe_foods/new'
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /create' do
      it 'returns http success' do
        get '/recipe_foods/create'
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end
  end
end
