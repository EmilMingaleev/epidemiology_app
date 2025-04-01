class Department < ApplicationRecord
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description created_at updated_at]
  end
end
