class ReviewsController < ApplicationController

  before_action :set_movie
  before_action :require_signin, except: [:index]
  # before_action :require_correct_user, only: [:create, :update, :destroy]

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_url, notice: "Thanks for your review!"
    else
      render :new
    end
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def update
    @review = @movie.reviews.find(params[:id])
    if @review.update review_params
      redirect_to movie_reviews_url, notice: "Your review has been updated!"
    else
      render :edit
    end
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_url, alert: "Review successfully deleted!"
  end


private

  def review_params
    params.require(:review).permit(:stars, :comment)
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end

end
