class AddFoodRefToRecipeFood < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_foods, :food_id, :integer
    add_index :recipe_foods, :food_id
  end
end
