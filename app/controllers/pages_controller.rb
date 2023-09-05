class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
  end

  def profil
  end

  def friends_list
  end

  def settings
  end
end
