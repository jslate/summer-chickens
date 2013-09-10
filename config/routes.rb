SummerChickens::Application.routes.draw do
  resources :playlists do
    member do
      post :add_song
      post :remove_song
    end
  end
  resources :songs
end
