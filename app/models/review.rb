class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # validation
  validates :rating, presence: true
  validates :comment, presence: true, length: { minimum: 10 }
end
