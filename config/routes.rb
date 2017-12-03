Rails.application.routes.draw do
  root 'welcome#index'

  localized do
    namespace :accounts do
      resources :sessions, only: %i[new create]
    end
  end
end
