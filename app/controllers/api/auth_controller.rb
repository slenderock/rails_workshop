class Api::AuthController < GrapeController
  namespace :auth do
    desc 'get auth'
    get do
      user = User.last

      present user, with: ::UserEntity::Full
    end

    desc 'create auth'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post do
      user = User.find_by(email: params[:email])

      if user&.authenticate(params[:password])
        present :user, user, with: ::UserEntity::Full
        present :token, JwtAuth.call(user: user).result
      else
        error_handler = ErrorFormatter.call(
          error: { user: 'unauthorized' },
          status: 401
        )

        error!(*error_handler.values_at(:json, :status))
      end
    end
  end
end
