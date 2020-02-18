class Api::UserController < ApiController
  before_action :authenticate!, only: %i[show destroy update]

  def create
    mutate_record User::Create.new(user_params)
  end

  def destroy
    if current_user.destroy
      render json: { success: true }
    else
      render_error current_user.errors.messages
    end
  end

  def update
    mutate_record User::Update.new(user_params, current_user)
  end

  def show
    render json: { user: represent(current_user) }
  end

  private

  def mutate_record(user_form)
    if user_form.save
      render json: { user: represent(user_form.user) }
    else
      render_error user_form.errors.messages
    end
  end

  def represent(record)
    UserEntity::Full.represent(record)
  end

  def user_params
    params.require(:user).permit(User::Base::ALL_ATTRIBUTES)
  end
end
