class Tag < ApplicationRecord
  has_and_belongs_to_many :ads
  validates :name, presence: true, length: {minimum: 3, maximum: 15}, uniqueness: { message: " is already exists"}
end
