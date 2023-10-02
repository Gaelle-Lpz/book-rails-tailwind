class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
  end

  def profil
  end

  def friends_list
    @friendship_pending = Friendship.where(friend: current_user, status: 0)
    @friends = current_user.friends
  end

  def settings
  end
end
