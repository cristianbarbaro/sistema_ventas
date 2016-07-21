Rails.application.routes.draw do
    root 'sales#new'

    resources :marks
    resources :categories
    resources :articles do
        resources :historics, only: [:index]
    end
    resources :providers
    resources :stocks, only: [:index]
    resources :sales, only: [:new, :create]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
