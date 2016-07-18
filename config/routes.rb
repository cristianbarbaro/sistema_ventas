Rails.application.routes.draw do
    root 'home#index'

    resources :marks
    resources :categories
    resources :articles
    resources :providers
    resources :stocks, only: [:index]
    resources :stocks
    resources :sales
    resources :historics
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
