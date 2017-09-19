class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  def user
    @user ||= User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    raise UserNotFound
  end

  def user_not_found
    render json: { type: 'user_not_found', error: 'NOT_FOUND' }, status: 404
  end

  class UserNotFound < StandardError; end

  rescue_from UserNotFound, with: :user_not_found
end
