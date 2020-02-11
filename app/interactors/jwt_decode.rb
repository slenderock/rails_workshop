require 'jwt'

class JwtDecode
  include Interactor

  def call
    decoded_token, = JWT.decode context.token, ENV['SECRET_KEY'], 'HS256'
    context.user = User.find(decoded_token['user_id'])
  rescue JWT::DecodeError, JWT::ExpiredSignature, ActiveRecord::RecordNotFound
    context.fail!(response: ErrorFormatter.call(error: { user: 'unauthorized' }))
  end
end
