require 'jwt'

class JwtAuth
  include Interactor

  def call
    payload = {
      user_id: context.user.id,
      exp: 1.month.from_now.to_i
    }

    context.result = JWT.encode payload, ENV['SECRET_KEY'], 'HS256'
  end
end