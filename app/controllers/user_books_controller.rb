class UserBooksController < ApplicationController
  before_action :find_user_book, only: %i[destroy archive]

  def create
    @user_book = current_user.user_books.find_by(book: Book.find(params[:book_id]))
    # Si non on crée un user_book
    @user_book = UserBook.new(book: Book.find(params[:book_id]), user: current_user) if @user_book.nil?
    #  On met à jour le status
    @user_book.status = (params[:status])
    @user_book.save!
    redirect_to dashboard_path, status: :see_other
  end

  def update
    # On change le statut du livre
    @user_book = UserBook.find_by(user: current_user, book_id: params[:book_id])
    @user_book.status = 2
    @user_book.save!
    # On ajoute les points à l'utilisateur
    update_user_score(current_user)
    redirect_to read_list_books_path
  end

  def destroy
    @user_book.destroy
    redirect_to dashboard_path, status: :see_other
  end

  def archive
    @user_book.status = 3
    @user_book.save!
    redirect_to dashboard_path
  end

  private

  def find_user_book
    @user_book = UserBook.find(params[:user_book_id])
  end

  def update_user_score(user)
    user_score = user.score + @user_book.book.score
    user.update_attribute(:score, user_score)
  end
end
