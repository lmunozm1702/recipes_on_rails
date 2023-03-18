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

  def general_shopping
    @foods_on_recipes = RecipeFood.group(:food_id).sum(:quantity)
    @shopping_list = []

    @foods_on_recipes.each do |food_id, quantity|
      @this_food = Food.find(food_id)
      @total_price = 0
      @items_to_buy = 0
      @item_list = add_list_item(food_id, quantity, @this_food)
      @shopping_list.push(@item_list)
      @total_price += @item_list[:price]
      @items_to_buy += 1 if (@item_list[:price]).positive?
    end

    [@shopping_list, @total_price, @items_to_buy]
  end

  private

  def add_list_item(_food_id, quantity, this_food)
    @response = if quantity > this_food.quantity
                  {
                    food_id: this_food.id,
                    food_name: this_food.name,
                    quantity: this_food.quantity - quantity,
                    price: (this_food.quantity - quantity) * this_food.price
                  }
                else
                  {
                    food_id: this_food.id,
                    food_name: this_food.name,
                    quantity: 0,
                    price: 0
                  }
                end
    @response
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity, :recipe_id)
  end
end
