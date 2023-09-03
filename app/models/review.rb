class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # validation
  validates :rating, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
