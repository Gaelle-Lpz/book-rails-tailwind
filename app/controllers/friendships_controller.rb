class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:user_id])
    @friendship = Friendship.new(user: current_user, friend: friend)
    @friendship.save!
    flash[:notice] = "Demande d'ami envoyée avec succès."
    redirect_to friends_path
  end

  def update
    friendship = Friendship.find(params[:id])
    friendship.accept!
    flash[:notice] = "Demande d'ami acceptée."
    redirect_to friends_path
  end

  def reject
    friendship = Friendship.find(params[:id])
    friendship.reject!
    flash[:notice] = "Demande d'ami rejetée."
    redirect_to friends_path
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    flash[:notice] = "Ami supprimé avec succès."
    redirect_to friends_path
  end

end
