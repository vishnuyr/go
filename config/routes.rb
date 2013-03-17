Go::Application.routes.draw do

  root :to => 'player_sessions#new'

  get     'login'   => 'player_sessions#new',     :as => :login
  post    'login'   => 'player_sessions#create'
  delete  'logout'  => 'player_sessions#destroy', :as => :logout

  get   'signup' => 'players#new', :as => :signup
  post  'signup' => 'players#create'

  resources :players, :only => [:edit, :update, :show]
  resources :games do
    member do
      get 'join' => 'games#join'
      resources :stones
    end
  end

end
