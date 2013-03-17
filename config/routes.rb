Go::Application.routes.draw do

  resources :players, :only => [:edit, :update, :show] do
    member do 
      resources :games, :except => :index
    end
  end

  get   'signup' => 'players#new', :as => :signup
  post  'signup' => 'players#create'


end
