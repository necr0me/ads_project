class Ad < ApplicationRecord
  enum status: [:draft, :moderating, :denied, :accepted, :published, :archived]
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploaders :pictures, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
