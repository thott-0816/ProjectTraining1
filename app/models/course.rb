class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :thumbnail, ImageUploader

  has_many :lessons, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :category
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :thumbnail, presence: true

  delegate :name, :avatar, :provider, :email, to: :user, prefix: :user
  delegate :name, to: :category, prefix: :category

  scope :list_all?, -> { order(created_at: :desc).select :id, :name, :description,
    :rate_average, :thumbnail, :user_id, :category_id, :created_at, :slug }

  scope :list_ratings_comment?, (lambda do |course_id|
    eager_load(:ratings, :comments).find_by id: course_id
  end)

  scope :by_name, (lambda do |name|
    ransack(name_eq: name).result
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
end
