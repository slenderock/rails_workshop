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
      user = User.last

      present user, with: ::UserEntity::Full
    end
  end
end