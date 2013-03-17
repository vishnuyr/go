Go::Application.routes.draw do

  resources :players, :only => [:edit, :update, :show]
  resources :games, :except => :index

  get   'signup' => 'players#new', :as => :signup
  post  'signup' => 'players#create'


end
