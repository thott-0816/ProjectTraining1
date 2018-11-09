class Course < ApplicationRecord
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

  scope :list_ratings_comment?, (lambda do |course_id|
    eager_load(:ratings, :comments).find_by id: course_id
  end)

  scope :list_all? , -> { order(created_at: :desc).select :id, :name, :description, :rate_average, :thumbnail, :user_id, :category_id, :created_at }

  def list_lessons?
    Lesson.where course_id: id
  end
end
