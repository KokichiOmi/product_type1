Rails.application.routes.draw do

  resources :comments, only: [:create]
  resources :contacts, only: [:new, :create]
  root to: 'posts#top'
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts do
    collection do
      post :confirm
    end  
  end
  resources :users
  resources :favorites, only: [:create, :destroy, :index]

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
    
end