class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_filter :authenticate_user!, only: :create

  def create
    UserCreationService.new(user_params).create.tap do |sign_in_response|
      render json: sign_in_response
    end
  end

  def me
    render json: current_user
  end

  def update
    current_user.tap do |user|
      user.update!(user_params)
      render json: user
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :old_password)
  end
end
