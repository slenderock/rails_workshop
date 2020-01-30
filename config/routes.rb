Rails.application.routes.draw do
  namespace :api do
    resource :user, only: [:create, :show, :update, :destroy], controller: :user
  end
end
