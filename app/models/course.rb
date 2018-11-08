class Course < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user

  delegate :name, :avatar, :provider, to: :user, prefix: :user

  scope :list_ratings_comment?, (lambda do |course_id|
    eager_load(:ratings, :comments).find course_id
  end)

  def list_lessons?
    Lesson.where course_id: id
  end
end
