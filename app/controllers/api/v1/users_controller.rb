class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_filter :authenticate_user!, only: :create

  def create
    user = User.create!(user_params)
    token = AccessToken.issue_for(user)
    sign_in_response = SignInResponse.new(user, token)
    render json: sign_in_response
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
