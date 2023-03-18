class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show update destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def update
    @recipe.public = !@recipe.public
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy

    redirect_to recipes_path
  end

  def shopping
    @shopping_list = Recipe.find(params[:id]).recipe_foods
    @shopping_list.each do |recipe_food|
      @this_food = Food.find(recipe_food.food_id)
      @total_price = 0
      @items_to_buy = 0

      recipe_food.class.module_eval { attr_accessor :total, :food_name }
      recipe_food.food_name = @this_food.name
      if recipe_food.quantity.nil? || recipe_food.quantity <= @this_food.quantity
        recipe_food.quantity = 0
        recipe_food.class.module_eval { attr_accessor :total, :food_name }
        recipe_food.total = 0
      else
        recipe_food.quantity -= @this_food.quantity
        recipe_food.total = recipe_food.quantity * @this_food.price
        @total_price += recipe_food.total
        @items_to_buy += 1
      end
    end
    [@shopping_list, @total_price, @items_to_buy]
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
