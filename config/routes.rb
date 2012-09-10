Notestoquiz::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => 'home#index'
  devise_for :users, :controllers => { :registrations => "registrations" } 
  resources :users, :only => [:show, :index]
  match 'authorize_dropbox' => "authorize_apps#authorize_dropbox", :via => :post
  match 'authorize_dropbox_done' => "authorize_apps#authorize_dropbox_done"
  match 'authorize_quizlet' => "authorize_apps#authorize_quizlet", :via => :post
  match 'authorize_quizlet_done' => "authorize_apps#authorize_quizlet_done"
end
