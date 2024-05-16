Rails.application.routes.draw do
  scope :api do
    resources :tasks, except: :show do
      collection do
        post 'complete/:id' => 'complete#tasks'
        post 'undo_complete/:id' => 'complete#tasks'
      end
    end
  end
end
