class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  delegate :name, :avatar, to: :user, prefix: :user

  scope :parent_comment?, -> {where(parent_id: nil)}

  def comment_child?
    Comment.where parent_id: id
  end
end
