Rails.application.routes.draw do
  resources :marks
  resources :categories
  resources :articles
  resources :providers
  resources :stocks
  resources :sales
  resources :historic
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
