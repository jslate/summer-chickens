class CreatePlaylistSongs < ActiveRecord::Migration
  def change
    create_table :playlist_songs do |t|
      t.references :song, null: false
      t.references :playlist, null: false
      t.integer :ordinal
      t.timestamps
    end
  end
end
