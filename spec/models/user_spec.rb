require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many food' do
      @user = User.new(email: 'a@a', password: '123456')
      @food = Food.create(name: 'Doro', user_id: @user.id, unit: 'grams', quantity: 1)
      expect(@food.user_id).to eq(@user.id)
    end

    it 'has many recipe' do
      @user = User.new(email: 'a@a', password: '123456')
      recipe = Recipe.new(name: 'a', user: @user)
      recipe.user = @user
      expect(recipe.user).to eq(@user)
    end
  end
end
