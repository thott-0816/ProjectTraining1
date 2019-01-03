class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :video_url, VideoUploader

  belongs_to :course

  validates :name, presence: true, uniqueness: true
  validates :video_url, presence: true

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def load_structure
    result = {
      id: id,
      name: name,
      url: video_url.url
    }
    result
  end
end
