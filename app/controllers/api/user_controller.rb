class Api::UserController < ApiController
  before_action :authenticate!, only: %i[show destroy update]

  def create
    user_form = User::Create.new(user_params)

    if user_form.save
      render json: { user: represent(user_form.user) }
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
    render json: { user: represent(current_user) }
  end

  private

  def represent(record)
    UserEntity::Full.represent(record)
  end

  def user_params
    params.require(:user).permit(User::Create::ATTRIBUTES)
  end
end
