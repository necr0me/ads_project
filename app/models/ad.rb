class Ad < ApplicationRecord
  enum status: [:draft, :moderating, :denied, :accepted, :published, :archived]
  belongs_to :user
  has_many :ad_logs #, dependent: :destroy
  has_and_belongs_to_many :tags
  default_scope -> { order(created_at: :desc) }
  mount_uploaders :pictures, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 340 }
  validates :reason, length: {maximum: 140}
end
