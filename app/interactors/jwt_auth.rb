class JwtAuth
  include Interactor

  def call
    context.user


  end
end