class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods 

  enum unit_type: %i[units grams]

  def self.list_all_foods
    Food.all.order(name: :asc)
  end
end
