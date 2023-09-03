class ReviewsController < ApplicationController
  before_action :find_book

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = current_user
    if @review.save
      redirect_to @book, notice: 'Commentaire ajouté avec succès.'
    else
      flash.now[:alert] = 'Erreur lors de l\'ajout du commentaire.'
      render 'books/show'
    end
  end

  private

  def find_book
    @book = Book.find(params[:book_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
