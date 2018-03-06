Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
	get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'

	resources :sessions, only: [:create, :destroy]
	resources :home, only: [:show]

  resources :ballots, except: [:show, :edit, :update]
  resources :votes
  resources :positions
  resources :candidates
  resources :users
  resources :groups
  resources :elections
	resources :elections do
		member do
			get 'results'
			get 'live'
		end
	end

	root to: "home#show"
end
