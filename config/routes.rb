Rails.application.routes.draw do
  resources :ballots
  get 'ballots/create'

  get 'ballots/show'

  get 'auth/:provider/callback', to: 'sessions#create'
	get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'

	resources :sessions, only: [:create, :destroy]
	resources :home, only: [:show]

  resources :votes
  resources :positions
  resources :candidates
  resources :users
  resources :groups
  resources :elections
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root to: "home#show"
end
