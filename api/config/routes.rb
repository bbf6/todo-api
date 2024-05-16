Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope :api do
    mount ActionCable.server => '/cable'

    resources :tasks, except: :show do
      collection do
        post 'complete/:id' => 'tasks#complete'
        post 'undo_complete/:id' => 'tasks#undo_complete'
      end
    end
  end
end
