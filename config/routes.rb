Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:show] do
        get :items
        get :invoices

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :customers, only: [:show] do
          get :invoices
          get :transactions

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :items, only: [:show] do
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoices, only: [:show] do
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoice_items, only: [:show] do
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :transactions, only: [:show] do
        collection do
          get :find
          get :find_all
          get :random
        end
      end
    end
  end

end
