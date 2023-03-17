class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      redirect_to @recipe_food.recipe, notice: 'Ingredient added successfully!'
    else
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    recipe = @recipe_food.recipe
    @recipe_food.destroy
    redirect_to recipe_path(recipe), notice: 'Ingredient removed successfully!'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity, :recipe_id)
  end
end