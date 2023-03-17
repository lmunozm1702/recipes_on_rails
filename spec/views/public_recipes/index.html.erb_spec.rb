require 'rails_helper'

RSpec.describe 'public_recipes/index.html.erb', type: :feature do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers

    before :each do
      @user = User.create(email: 'aa@a', password: '123456')
      visit new_user_session_path
      @user.confirm
      sign_in @user
      find('input[type="submit"]').click
      @recipe = Recipe.create(name: 'Doro', user: @user, public: true)
      visit public_recipes_path
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

    it 'should display the total food item' do
      expect(page).to have_content('Total food items: 0')
    end

    it 'should display the total price' do
      expect(page).to have_content('Total price: $')
    end

    it 'should display the owner\'s name' do
      expect(page).to have_content('By:')
    end
  end
end
