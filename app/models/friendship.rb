class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  # status pending:0 accepted:1 rejected:2 blocked:3

  def accept!
    update(status: 1)
  end

  def reject!
    update(status: 2)
  end
end
