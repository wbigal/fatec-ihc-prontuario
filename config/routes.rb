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

    namespace :doctors do
      resources :medical_records, only: %i[index new create] do
        collection do
          get :patient_records
        end
      end
      resources :permissions, only: %i[destroy]
      resources :my_appointments, only: %i[index] do
        collection do
          get :search_result
        end
      end
    end
  end
end
