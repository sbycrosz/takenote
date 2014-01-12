class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_filter :authenticate_user!, only: :create

  def create
    sign_in_response = SessionCreationService.new(params[:username], params[:password]).create
    render json: sign_in_response
  end

  def destroy
    doorkeeper_token.destroy
    head(:ok)
  end
end
