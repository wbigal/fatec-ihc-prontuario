Rails.application.routes.draw do
  root 'welcome#index'

  localized do
    namespace :accounts do
      resource :sessions, only: %i[new create destroy]
    end

    namespace :patients do
      resources :permissions, only: %i[index new create destroy] do
        collection do
          get :search_doctor
        end
      end
    end
  end
end
