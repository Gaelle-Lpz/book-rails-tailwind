class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books
  has_many :reviews

  # enum :status, { wished: 0, pending: 1, read: 2, archive: 3 }

  validates :isbn, uniqueness: true

  def average_rating
    total_rating = reviews.sum { |review| review.rating.to_f }
    valid_reviews_count = reviews.count { |review| !review.rating.nil? }

    return total_rating / valid_reviews_count if valid_reviews_count.positive?

    0.0
  end
end
