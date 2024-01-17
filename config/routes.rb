Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ru/ do
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }

    devise_scope :user do
      authenticated :user do
        root 'incomes#index', as: :authenticated_root
      end
      unauthenticated do
        root 'devise/sessions#new', as: :unauthenticated_root
      end
    end

    authenticated :user do
      resources :income_categories, except: [:show]
      resources :payment_categories, except: [:show]
      resources :incomes, controller: 'incomes', except: %i[index show]
      resources :payments, controller: 'payments', except: %i[index show]
      resources :charts, controller: 'charts', except: %i[index show]
      get 'settings', to: 'settings#index'
      get 'incomes', to: 'incomes#index'
      get 'payments', to: 'payments#index'
      get 'charts', to: 'charts#index'
    end
  end
  root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root
end
