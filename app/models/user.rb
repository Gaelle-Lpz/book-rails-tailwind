class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_books
  has_many :books, through: :user_books
  has_many :reviews

  # Validation
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)/, message: "au minimum 6 caractères dont au moins un chiffre, une lettre majuscule et un caractère spécial." }
end
