require 'rails_helper'

RSpec.describe 'Food new test', type: :feature do
  describe 'when user is signed in' do
    include Devise::Test::IntegrationHelpers

    before :each do
      @user = User.create(email: 'aa@a', password: '123456')
      visit new_user_session_path
      @user.confirm
      sign_in @user
      find('input[type="submit"]').click
      @food = Food.create(name: 'Doro', user: @user, unit: 'grams', quantity: 1)
      visit new_food_path
    end

    it 'should render the new food page' do
      expect(page).to have_content('New Food')
    end

    it 'should render the create food button' do
      expect(page).to have_selector('input[type="submit"][value="Create Food"].btn.btn-primary')
    end

    it 'should render the bact to foods button' do
      expect(page).to have_link("Back to foods", href: foods_path, class: "btn btn-secondary btn-sm")
    end
  end
end