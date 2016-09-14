Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users, only: [:show]
  resources :posts do
    resources :attachments, except: [:index]
    resources :comments, only: [:create, :destroy]
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
  end
  root 'posts#index'
end
