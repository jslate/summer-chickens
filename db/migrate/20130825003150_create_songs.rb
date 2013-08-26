class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :composer
      t.string :artist
      t.string :key
      t.integer :tempo
      t.string :notes
      t.text :lead_sheet

      t.timestamps
    end
  end
end
