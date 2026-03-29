module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::Cookies

      rescue_from StandardError, with: :handle_internal_error
      rescue_from ActionController::ParameterMissing, with: :handle_bad_request

      private

      def authenticate_user!
        token = cookies.signed[:auth_token]
        return render_unauthorized unless token

        payload = JwtService.decode(token)
        @current_user = User.find_by(id: payload[:user_id])
        render_unauthorized unless @current_user
      rescue JwtService::DecodeError
        render_unauthorized
      end

      def render_unauthorized(message = "Unauthorized")
        render json: { message: message }, status: :unauthorized
      end

      def render_unprocessable_entity(record)
        render json: { errors: record.errors.messages }, status: :unprocessable_entity
      end

      def handle_internal_error(exception)
        Rails.logger.error(exception.full_message)
        render json: { message: "Internal server error" }, status: :internal_server_error
      end

      def handle_bad_request(exception)
        render json: { message: exception.message }, status: :bad_request
      end
    end
  end
end
