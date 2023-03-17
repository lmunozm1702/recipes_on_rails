require 'rails_helper'

RSpec.describe 'Food show test', type: :feature do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers

    before :each do
      @user = User.create(email: 'aa@a', password: '123456')
      visit new_user_session_path
      @user.confirm
      sign_in @user
      find('input[type="submit"]').click
      @food = Food.create(name: 'Doro', user: @user, unit: 'grams', quantity: 1)
      visit food_path(@food)
    end

    it 'should display the user\'s username' do
      expect(page).to have_content(@user.email)
    end

    it 'should display the user\'s name' do
      expect(page).to have_content(@user.name)
    end

    it 'should display the food name' do
      expect(page).to have_content(@food.name)
    end

    it 'should display the measurement unit' do
      expect(page).to have_content(@food.unit)
    end

    it 'should display the quantity' do
      expect(page).to have_content(@food.quantity)
    end

    it 'should display the owners id' do
      expect(page).to have_content(@user.id)
    end
  end
end
