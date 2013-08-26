SummerChickens::Application.routes.draw do
  resources :playlists
  resources :songs do
    member do
      post :add_to_playlist
    end
  end
end
