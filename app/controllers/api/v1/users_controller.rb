class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if current_user.update_attributes(user_params)
      render json: current_user, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }
             # status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit( :first_name, :last_name, :email, :password, :password_confirmation )
  end

end
