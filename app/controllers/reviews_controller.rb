class ReviewsController < ApplicationController

  before_filter :require_login

  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user = current_user
    if @review.save
      redirect_to '/'
    else
      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def destroy
    Review.find_by(id: params[:id]).destroy
    redirect_to "/products/#{params[:product_id]}"
  end

  private

    def require_login
      unless current_user
        redirect_to '/login'
      end
    end

    def review_params
      params.require(:review).permit(:description, :rating)
    end

end
