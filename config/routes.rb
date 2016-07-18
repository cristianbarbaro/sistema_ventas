Rails.application.routes.draw do
    root 'home#index'

    resources :marks
    resources :categories
    resources :articles do
        resources :historics, only: [:index]
    end
    resources :providers
    resources :stocks, only: [:index]
    resources :sales
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
