module Api::V1::ExceptionsRenderer
  extend ActiveSupport::Concern

  def render_error(message, status)
    render json: {error: message}, status: status
  end

  def render_invalid_record(e)
    message = e.record.errors
    render_error message, :unprocessable_entity
  end

  def render_active_record_not_found(e)
    message = "Resource not found"
    render_error message, :not_found
  end

  def render_unauthorized(e)
    render_error e.message, :unauthorized
  end
end
