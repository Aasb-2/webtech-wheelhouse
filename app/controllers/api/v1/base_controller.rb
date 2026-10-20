module Api
  module V1
    class BaseController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActionController::ParameterMissing, with: :render_bad_request
      rescue_from ActionDispatch::Http::Parameters::ParseError, with: :render_bad_request

      private

      def authenticate_token!
        token = ActionController::HttpAuthentication::Token.token_and_options(request)&.first
        expected_token = Rails.application.credentials.dig(:api, :token).to_s

        return if token.present? && ActiveSupport::SecurityUtils.secure_compare(token, expected_token)

        render_errors(["Invalid or missing token"], :unauthorized)
      end

      def render_errors(messages, status)
        render json: { errors: Array(messages) }, status: status
      end

      def render_not_found(_exception)
        render_errors(["Resource not found"], :not_found)
      end

      def render_bad_request(exception)
        render_errors([exception.message], :bad_request)
      end
    end
  end
end