class CommentRate

  include ActiveModel::Model

  attr_accessor :rating, :course_id, :content, :parent_id, :current_user

  validates :content, presence: true
  validates :course_id, presence: true
  validates :current_user, presence: true

  def initialize params=nil, current_user=nil
    unless current_user.nil?
      @current_user = current_user
      @content = params.fetch(:content)
      @course_id = params.fetch(:course_id)
      @parent_id = params.fetch(:parent_id)
      @rating = params.fetch(:rating)
    end
  end

  def save
    return false unless valid?
    if rating.present?
      ActiveRecord::Base.transaction do
        create_rating
        create_comment
        update_course
      end
    else
      create_comment
    end
    true
  end
  
  private
  def create_rating
    Rating.create!(
      rating: rating,
      user_id: current_user.id,
      course_id: course_id
    )
  end

  def create_comment
    Comment.create!(
      content: content,
      user_id: current_user.id,
      course_id: course_id,
      parent_id: parent_id
    )
  end

  def update_course
    Course.find_by(id: course_id).update_rating
  end
end
