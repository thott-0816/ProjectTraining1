class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :thumbnail, ImageUploader

  has_many :courses, dependent: :destroy
  has_many :children, class_name: Category.name, foreign_key: "parent_id",
    dependent: :destroy
  belongs_to :parent, class_name: Category.name, optional: true

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

  scope :list_all_categories?, -> { eager_load(:courses) }
  scope :category_select, -> { select :id, :name, :parent_id, :description, :thumbnail }
  scope :roots, -> parent_id{where(parent_id: parent_id)}
  scope :get_all_category, -> {select(:id, :name, :parent_id, :description, :slug)}
  scope :root_category, -> {select(:id, :name, :slug).where(parent_id: nil)}

  def load_structure
    result = {
      id: id,
      name: name,
      parent_id: parent_id,
      description: description,
      thumbnail: thumbnail,
      courses: courses
    }
    result
  end

  def descendents
    children || self.children.map(&:descendents).flatten
  end

  def has_courses?
    courses.present?
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
