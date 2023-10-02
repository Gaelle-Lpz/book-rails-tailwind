class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_books
  has_many :books, through: :user_books
  has_many :reviews

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id', dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  # Validation
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)/, message: "au minimum 6 caractères dont au moins un chiffre, une lettre majuscule et un caractère spécial." }

  def friendship_status_with(friend)
    friendship = Friendship.find_by(user_id: self.id, friend_id: friend.id)
    return :none if friendship.nil?

    return friendship.status
  end

  def friends
    friends_ids = Friendship.where("(user_id = ? OR friend_id = ?) AND status = 1", self.id, self.id)
                            .pluck(:user_id, :friend_id)
                            .flatten.uniq - [self.id]
    User.where(id: friends_ids)
  end
end
