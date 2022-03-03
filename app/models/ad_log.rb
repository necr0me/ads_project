class AdLog < ApplicationRecord
  enum to: [:draft, :moderating, :denied, :accepted, :published, :archived], _prefix: :to
  enum from: [:draft, :moderating, :denied, :accepted, :published, :archived], _prefix: :from
  belongs_to :ad
end
