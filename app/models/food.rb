class Food < ApplicationRecord
  belongs_to :user

  def self.list_all_foods
    Food.all.order(name: :asc)
  end
end
