Rails.application.routes.draw do
  root 'welcome#index'

  localized do
    namespace :accounts do
      resource :sessions, only: %i[new create destroy]
    end
  end
end
