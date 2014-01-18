class Api::V1::SessionsController < Api::V1::ApplicationController
  skip_before_filter :authenticate_user!, only: :create

  def create
    token = SessionCreationService.new(params[:username], params[:password]).create
    render json: token
  end

  def destroy
    doorkeeper_token.destroy
    head(:ok)
  end
end
