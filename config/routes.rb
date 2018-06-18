Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root 'sales#new'
    
    resources :marks
    resources :categories
    resources :articles do
        resources :historics, only: [:index]
    end
    resources :providers
    resources :stocks, only: [:index, :edit, :update]
    resources :sales, only: [:new, :create, :index, :show]
    scope 'admin', as: 'admin' do
      resources :users, except: [:new, :create]
    end
    # Update prices for providers (in mass).
    get 'update_prices', to: 'articles#update_prices'
    post 'update_prices', to: 'articles#update_prices_post'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
