require 'rails_helper'

RSpec.describe 'recipe_foods/new.html.erb', type: :feature do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers

    before :each do
      @user = User.create(email: 'aa@a', password: '123456')
      visit new_user_session_path
      @user.confirm
      sign_in @user
      find('input[type="submit"]').click
      @recipe = Recipe.create(name: 'Doro', user: @user)
      visit new_recipe_food_path(recipe_id: @recipe.id)
    end

    it 'should render the new recipe page' do
      expect(page).to have_content('Add Ingredient')
    end

    it 'should render the create recipe button' do
      expect(page).to have_selector('input[type="submit"][value="Create Recipe food"].btn.btn-primary')
    end
  end
end
