class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :wallet, dependent: :destroy
  has_one :e_wallet, inverse_of: :user, dependent: :destroy
  
  validates :name, presence: true
  validates_integrity_of :avatar
  validates_processing_of :avatar
  validate :avatar_size

  delegate :account, to: :wallet, prefix: :wallet, allow_nil: true

  enum role: {student: 0, lecture: 1, admin: 2}

  scope :can_post_course, -> { where(role: roles.except(:student).values).collect{|user| [user.name, user.id]} }

  scope :search_users, (lambda do |text_search|
    ransack(name_cont: text_search).result    
  end)

  def check_rating? course_id
    ratings.where(course_id: course_id).present?
  end

  def update_wallet? price
    wallet.nil? ? Wallet.create!(account: price, user_id: id) : wallet.increment!(:account, price)
  end

  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.provider = auth.provider
        user.uid = auth.uid
        user.password = Devise.friendly_token[0,20]
      end
    end
  end

  def load_attribute_user
    authorize_token = JsonWebToken.encode user_id: id
    {
      name: name,
      email: email,
      provider: provider,
      avatar: avatar_user(avatar),
      role: role,
      uid: uid,
      created_at: created_at,
      token: authorize_token
    }
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  private
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add :avatar, I18n.t("users.avatar_size_error")
    end
  end

  def avatar_user avatar
    {
      "url": avatar.url,
      "big_url": avatar.big.url,
      "standard_url": avatar.standard.url,
      "thumb_url": avatar.thumb.url
    }
  end
end
