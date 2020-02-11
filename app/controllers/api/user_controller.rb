class Api::UserController < ApiController
  def create
    user_form = User::Create.new(user_params)

    if user_form.save
      render json: { user: user_form.serialized_record }
    else
      render_error user_form.errors.messages
    end
  end

  def destroy
    render json: { action: action_name }
  end

  def update
    render json: { action: action_name }
  end

  def show
    command = JwtDecode.call(token: request.headers['Authorization'])
    if command.success?
      render json: { user: UserEntity::Full.represent(command.user) }
    else
      render command.response
    end

  end

  private

  def user_params
    params.require(:user).permit(User::Create::ATTRIBUTES)
  end
end
