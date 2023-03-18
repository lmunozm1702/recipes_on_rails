require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers
    before do
      @user = User.create(email: 'a@a', password: '123456')
      @recipe = Recipe.create(name: 'Doro', user: @user)
      sign_in @user
    end

    describe 'GET /recipes' do
      it 'returns http success' do
        get '/recipes'
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /recipes/:id' do
      it 'returns http success' do
        get "/recipes/#{@recipe.id}"
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /recipes/new' do
      it 'returns http success' do
        get '/recipes/new'
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /recipes' do
      it 'creates a new recipe' do
        post '/recipes', params: { recipe: { name: 'Shiro', user_id: @user.id } }
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'PATCH /recipes/:id' do
      it 'updates an existing recipe' do
        patch "/recipes/#{@recipe.id}", params: { recipe: { name: 'Shiro' } }
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end

    describe 'DELETE /recipes/:id' do
      it 'deletes an existing recipe' do
        delete "/recipes/#{@recipe.id}"
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end
  end
end
