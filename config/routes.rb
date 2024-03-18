Rails.application.routes.draw do
  mount LikeDislike::Engine, at: '/'
  get 'contact_messages/new'
  get 'contact_messages/create'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :blog_posts do
    resource :cover_image, only: [:destroy], module: :blog_posts
  end

  resources :contact_messages, only: [:new, :create]
   
  resources :blog_posts do
    member do
      post 'like'
      post 'dislike'
    end
  end
  
  # Defines the root path route ("/")
  root "blog_posts#index"
end
