class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :thumbnail, ImageUploader

  has_many :lessons, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :category
  belongs_to :user

  validates :name, presence: true

  delegate :name, :avatar, :provider, :email, to: :user, prefix: :user
  delegate :name, to: :category, prefix: :category

  scope :list_all?, -> { order(created_at: :desc).select :id, :name, :description,
    :rate_average, :thumbnail, :user_id, :category_id, :created_at, :slug }

  scope :search_courses, (lambda do |text_search|
    where("MATCH (description, name) AGAINST ('#{text_search}')")
  end)

  scope :list_ratings_comment?, (lambda do |course_slug|
    eager_load(:ratings, :comments).friendly.find_by_slug course_slug
  end)

  scope :by_name, (lambda do |name|
    ransack(name_cont: name).result
  end)

  scope :by_category, (lambda do |category_id|
    ransack(category_id_eq: category_id).result
  end)

  scope :by_author, (lambda do |author_id|
    ransack(user_id_eq: author_id).result
  end)

  scope :by_description, (lambda do |description|
    ransack(description_cont: description).result
  end)

  def list_lessons?
    Lesson.where course_id: id
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def update_rating
    update_column :rate_average, Rating.where(course_id: id).average(:rating).to_f.round(1)
  end

  def price_sale
    price * (100 - percent_sale) / 100
  end

  def load_structure
    result = {
      id: id,
      name: name,
      description: description,
      thumbnail: thumbnail,
      rate_average: rate_average,
      user_id: user_id,
      category_id: category_id,
      comments: comments.select(:id, :content, :parent_id, :user_id)
    }
    result
  end
end
