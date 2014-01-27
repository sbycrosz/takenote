class Api::V1::ApplicationController < ActionController::Base
  include Api::V1::ExceptionsHandler

  doorkeeper_for :all
  before_filter :authenticate_user!

  respond_to :json

  ActiveModel::ArraySerializer.root = 'data'
  ActiveModel::Serializer.root = false

  protected

  def current_user
    @current_user ||= if doorkeeper_token.resource_owner_id
      User.find(doorkeeper_token.resource_owner_id)
    end
  end

  private

  def authenticate_user!
    raise Exceptions::NotAuthenticated unless doorkeeper_token.resource_owner_id
  end
end
