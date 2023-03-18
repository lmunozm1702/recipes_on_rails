Rails.application.routes.draw do
  resources :foods, only: [:index, :show, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :new, :create, :update, :destroy]
  resources :public_recipes, only: [:index]
  resources :recipe_foods, only: [:new, :create, :destroy]
  devise_for :users

  resources :recipes do
    get ":id/shopping", to: "recipes#shopping", on: :collection, as: 'shopping'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "foods#index"
  get "general_shopping", to: "recipe_foods#general_shopping", as: 'general_shopping'
end

