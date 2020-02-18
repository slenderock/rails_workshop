class ApiController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  attr_reader :current_user

  private

  def parameter_missing(error)
    render ErrorFormatter.call(
      error: { error.param => 'is missing or the value is empty' }
    )
  end

  def render_error(errors = {}, status = :unprocessable_entity )
    render ErrorFormatter.call(errors: errors, status: status)
  end

  def authenticate!
    command = JwtDecode.call(token: request.headers['Authorization'])
    @current_user = command.user
    render(command.response) unless command.success?
  end
end
