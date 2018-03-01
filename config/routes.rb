Rails.application.routes.draw do
  resources :votes
  resources :positions
  resources :candidates
  resources :users
  resources :groups
  resources :elections
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
