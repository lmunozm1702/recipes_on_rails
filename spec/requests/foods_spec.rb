require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers
    before do
      @user = User.create(email: 'a@a', password: '123456')
      @food = Food.create(name: 'Doro', user_id: @user.id, unit: 'grams', quantity: 1)
      sign_in @user
    end

    describe 'GET /foods' do
      it 'returns http success' do
        get '/foods'
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /foods/:id' do
      it 'returns http success' do
        get "/foods/#{@food.id}"
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /foods/new' do
      it 'returns http success' do
        get '/foods/new'
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /foods' do
      it 'creates a new food' do
        post '/foods', params: { food: { name: 'Shiro', user_id: @user.id } }
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PATCH /foods/:id' do
      it 'updates an existing food' do
        patch "/foods/#{@food.id}", params: { food: { name: 'Shiro' } }
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'DELETE /foods/:id' do
      it 'deletes an existing food' do
        delete "/foods/#{@food.id}"
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end
  end
end
