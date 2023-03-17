require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      @user = User.new(email: 'a@a', password: '123456')
      recipe = Recipe.new(name: 'a', user: @user)
      recipe.user = @user
      expect(recipe.user).to eq(@user)
    end

    it 'has many recipe foods' do
      @user = User.create(email: 'a@a', password: '123456')
      @recipe = Recipe.new(name: 'a', user: @user)
      @food = Food.new(name: 'a', user_id: @user.id)
      recipe_food = RecipeFood.create(quantity: 2, food: @food, recipe: @recipe)
      expect(@recipe.recipe_foods).to include(recipe_food)
    end
  end
end
