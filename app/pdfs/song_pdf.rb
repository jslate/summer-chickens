class SongPdf < Prawn::Document

  CHORD_REGEX = /([^\[]*)\[([^\[]*)\]([^\[]*)/

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
    lines.each_with_index do |line, index|
      start_new_page if index > 0 && index % 20 == 0
      move_down 40
      x = 0
      y_pos = y
      if line.match CHORD_REGEX
        line.scan(CHORD_REGEX) do |start, chord, finish|
          text_box start, at: [0, y]
          x += width_of(start)
          text_box chord, at: [x, y_pos + 15]
          finish_box = text_box finish, at: [x, y_pos]
          x += width_of(finish)
        end
      else
        text_box line, at: [0, y]
      end
    end
  end

end
