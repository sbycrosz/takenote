module Api::V1::ExceptionsHandler
  extend ActiveSupport::Concern
  included do
    include Api::V1::ExceptionsRenderer
    rescue_from ActiveRecord::RecordNotFound, with: :render_active_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record
    rescue_from Exceptions::NotAuthenticated, with: :render_unauthorized
    rescue_from Exceptions::AuthenticationFailed, with: :render_unauthorized
  end
end
