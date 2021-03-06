class ReviewsController < ApplicationController
  #before_action :set_company, only: [:index, :create]
  #before_action :set_company_review, only: [:show, :update, :destroy]

  def indexall
    @allreviews = Review.all
    json_response(@allreviews)
  end

  # GET /users/:user_id/company
  def index
    @company = Company.find(params[:company_id])
    json_response(@company.reviews)
  end

  # POST /users/:user_id/company
  def create
    @company = Company.find(params[:company_id])
    @review = @company.reviews.create!(review_params)
    # json_response(@review, :created)
    json_response(status: "SUCCESS", message: 'Review created successfully.', data: @review)
  end


  # GET /users/:user_id/companies/:id/review/:id
  def show
    @company = Company.find(params[:company_id])
    @review = @company.reviews.find_by!(id: params[:id]) if @company
    json_response(@review)
  end

  # PUT /users/:user_id/company/:company_id/reviews/:review_id
  def update
    @company = Company.find(params[:company_id])
    @review = @company.reviews.find_by!(id: params[:id]) if @company
    @review.update(review_params)
    json_response(@review)
  end

  # DELETE /users/:users_id/company/:company_id/reviews/:review_id
  def destroy
    @company = Company.find(params[:company_id])
    @review = @company.reviews.find_by!(id: params[:id]) if @company
    @review.destroy
    json_response(status: 'SUCCESS', message: 'Review deleted successfully.', data: @review)
  end

  private

  def review_params
    params.permit(:user_id, :submitted_user, :submitted_company, :review, :done)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_company_review
    @review = @company.reviews.find_by!(id: params[:id]) if @company
  end
end
