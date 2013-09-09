class Playlist < ActiveRecord::Base
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  def available_songs
    Song.where(['not exists (select id from playlist_songs where playlist_songs.song_id = songs.id and playlist_id = ?)', id])
  end

end
