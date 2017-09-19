class UsersController < ApplicationController
  def create
    CreateUser.run(params).match do
      success do |user|
        render json: user
      end

      failure do |error|
        render json: error, status: 422
      end
    end
  end

  def update
    user.update_attributes(name: params[:name])
    render json: user
  end

  def index
    render json: User.all
  end

  def assigned
    render json: user.assigned_tickets
  end

  def own
    render json: user.own_tickets
  end
end
