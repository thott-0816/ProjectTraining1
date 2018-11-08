class Category < ApplicationRecord
  mount_uploader :thumbnail, ImageUploader

  has_many :courses, dependent: :destroy
  has_many :children, class_name: Category.name, foreign_key: "parent_id",
    dependent: :destroy
  belongs_to :parent, class_name: Category.name, optional: true

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  scope :list_all_categories?, -> { eager_load(:courses) }
  scope :roots, -> parent_id{where(parent_id: parent_id)}

  def has_courses?
    courses.present?
  end
end
