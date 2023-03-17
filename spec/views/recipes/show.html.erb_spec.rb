require 'rails_helper'

RSpec.describe 'Recipe index test', type: :feature do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers

    before :each do
      @user = User.create(email: 'aa@a', password: '123456')
      visit new_user_session_path
      @user.confirm
      sign_in @user
      find('input[type="submit"]').click
      @recipe = Recipe.create(name: 'Doro', user: @user)
      visit recipe_path(@recipe)
    end

    it 'should display the user\'s username' do
      expect(page).to have_content(@user.email)
    end

    it 'should display the user\'s name' do
      expect(page).to have_content(@user.name)
    end

    it 'should display the recipe name' do
      expect(page).to have_content(@recipe.name)
    end

    it 'should display the preparation time' do
      expect(page).to have_content('Preparation time:')
    end

    it 'should display the cooking time' do
      expect(page).to have_content('Cooking time:')
    end
  end
end
