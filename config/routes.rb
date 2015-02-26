SummerChickens::Application.routes.draw do
  root :to => 'home#index'

  resource :home, only: [:index]

  resources :playlists do
    member do
      post :add_song
      post :remove_song
    end
  end
  resources :songs
end
