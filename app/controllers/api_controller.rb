class ApiController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def parameter_missing(error)
    render_error(error.param => ['is missing or the value is empty'])
  end

  def render_error(errors = {}, status = :unprocessable_entity )
    render json: { errors: errors }, status: status
  end
end