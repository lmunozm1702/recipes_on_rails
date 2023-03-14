class Food < ApplicationRecord
  belongs_to :user

  enum unit_type: %i[units grams]

  def self.list_all_foods
    Food.all.order(name: :asc)
  end
end
