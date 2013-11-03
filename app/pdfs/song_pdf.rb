class SongPdf < Prawn::Document
  def initialize(songs)
    super(top_margin: 40)
    font 'Helvetica'
    songs.each_with_index do |song, i|
      title(song)
      lead_sheet(song)
      start_new_page unless i == songs.length - 1
    end
  end

  def title(song)
    text song.title, size: 25, style: :bold
    bounding_box([400, cursor + 30], width: 400) do
      text "Written by #{song.composer}" if song.composer.present?
      text "Performed by #{song.artist}" if song.artist.present?
    end
    move_down 40
  end

  def lead_sheet(song)
    lines = song.lead_sheet.split(/\n/)
    lines.each do |line|
      move_down 40
      x = 0
      y_pos = y
      line.scan(/([^\[]*)\[([^\[]*)\]([^\[]*)/) do |start, chord, finish|
        text_box start, at: [0, y]
        x += width_of(start)
        text_box chord, at: [x, y_pos + 15]
        finish_box = text_box finish, at: [x, y_pos]
        x += width_of(finish)
      end
    end
  end

end
