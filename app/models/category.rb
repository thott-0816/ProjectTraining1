class Category < ApplicationRecord
  has_many :courses, dependent: :destroy

  scope :list_all_categories?, -> { eager_load(:courses) }
  
  def has_courses?
    courses.present?
  end
end
