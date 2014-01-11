class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_filter :authenticate_user!, only: :create

  def create
    user = User.create!(user_params)
    render json: user
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
