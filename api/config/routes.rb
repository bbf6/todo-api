Rails.application.routes.draw do
  scope :api do
    mount Rswag::Ui::Engine => '/docs'
    mount Rswag::Api::Engine => '/docs'
    mount ActionCable.server => '/cable'

    resources :tasks, except: :show do
      collection do
        post 'complete/:id' => 'tasks#complete'
        post 'undo_complete/:id' => 'tasks#undo_complete'
      end
    end
  end
end
