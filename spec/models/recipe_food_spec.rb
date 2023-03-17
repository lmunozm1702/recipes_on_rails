require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it 'belongs to a recipe' do
      recipe = Recipe.create(name: 'a')
      recipe_food = RecipeFood.create(quantity: 2, recipe: recipe)
      expect(recipe_food.recipe).to eq(recipe)
    end

    it 'belongs to a food' do
      food = Food.create(name: 'a')
      recipe_food = RecipeFood.create(quantity: 2, food: food)
      expect(recipe_food.food).to eq(food)
    end
  end
end
