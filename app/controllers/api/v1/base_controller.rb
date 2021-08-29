# Boilerplate code that almost every API will have
class Api::V1::BaseController < ActionController::API
  # use pundit's features for the controllers of the API
  include Pundit

  # slightly different logic for many objects (index), as single objects (others)
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # Errors are usually displayed in HTML. For APIs, we want  to render JSON erros
  # the private methods defined below render the desired errors that will be displayed in JSON
  rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def user_not_authorized(exception)
    render json: {
      error: "Unauthorized #{exception.policy.class.to_s.underscore.camelize}.#{exception.query}"
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
