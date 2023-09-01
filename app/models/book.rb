class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books
  has_many :reviews

  # enum :status, { wished: 0, pending: 1, read: 2, archive: 3 }
end
