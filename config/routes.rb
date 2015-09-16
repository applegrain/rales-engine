Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:show, :index] do
        get :items
        get :invoices
        get :revenue
        get :customers_with_pending_invoices
        get :favorite_customer

        collection do
          get :find
          get :find_all
          get :random
          get :revenue, to: :all_merchants_revenue
          get :most_revenue
          get :most_items
        end
      end

      resources :customers, only: [:show, :index] do
          get :invoices
          get :transactions
          get :favorite_merchant

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :items, only: [:show, :index] do
        get :invoice_items
        get :merchant
        get :best_day

        collection do
          get :find
          get :find_all
          get :random
          get :most_items
          get :most_revenue
        end
      end

      resources :invoices, only: [:show, :index] do
        get :transactions
        get :invoice_items
        get :items
        get :customer
        get :merchant

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoice_items, only: [:show, :index] do
        get :invoice
        get :item

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :transactions, only: [:show, :index] do
        get :invoice

        collection do
          get :find
          get :find_all
          get :random
        end
      end
    end
  end
end
