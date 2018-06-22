class Post < ApplicationRecord
  validates :image, presence: true
  validates :content, length: { in: 1..140 }
  mount_uploader :image, ImageUploader
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments
end