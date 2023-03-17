require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      @user = User.new(email: 'a@a', password: '123456')
      @food = Food.create(name: 'Doro', user_id: @user.id, unit: 'grams', quantity: 1)
      expect(@food.user_id).to eq(@user.id)
    end

    it 'has many recipe foods' do
      @user = User.create(email: 'a@a', password: '123456')
      @recipe = Recipe.new(name: 'a', user: @user)
      @food = Food.new(name: 'a', user_id: @user.id)
      recipe_food = RecipeFood.create(quantity: 2, food: @food, recipe: @recipe)
      expect(@recipe.recipe_foods).to include(recipe_food)
    end

    it "returns all foods in alphabetical order" do
      @user = User.create(email: 'a@a', password: '123456')
      @food = Food.create(name: 'Doro', user_id: @user.id, unit: 'grams', quantity: 1)
      @food2 = Food.create(name: 'Doro', user_id: @user.id, unit: 'grams', quantity: 1)
      foods = Food.list_all_foods
      
      expect(foods).to eq(foods.reverse)
    end
  end
end