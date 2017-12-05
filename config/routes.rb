Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    resources :people, only: %i[create]
    resources :doctors, only: %i[create]
  end

  localized do
    namespace :accounts do
      resource :sessions, only: %i[new create destroy]
      resources :registrations, only: %i[index new create]
      resources :passwords, only: %i[index edit update] do
        collection do
          get :remember
        end
      end
    end

    namespace :patients do
      resources :permissions, only: %i[index new create destroy] do
        collection do
          get :search_doctor
        end
      end
      resources :my_medical_records, only: %i[index show] do
        collection do
          get :search_result
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
      resources :my_appointments, only: %i[index show] do
        collection do
          get :search_result
        end
      end
    end
  end
end
