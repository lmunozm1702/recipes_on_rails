require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers
    before do
      @user = User.create(email: 'a@a', password: '123456')
      sign_in @user
    end

    describe 'GET /index' do
      it 'returns http success' do
        get '/public_recipes/index'
        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end
  end
end
