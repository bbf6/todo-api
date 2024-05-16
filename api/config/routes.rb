Rails.application.routes.draw do
  scope :api do
    resources :tasks, except: :show
  end
end
