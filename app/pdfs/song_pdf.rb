class SongPdf < Prawn::Document

  CHORD_REGEX = /([^\[]*)\[([^\[]*)\]([^\[]*)/
  INSTRUCTION_REGEX = /\A_(.*)_\s*\Z/

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
      start_new_page if index > 0 && index % 30 == 0
      move_down(line.blank? ? 10 : 25)
      x = 0
      y_pos = y
      if line.match INSTRUCTION_REGEX
        text_box $1, at: [0, y], size: 10, style: :italic
      elsif line.match CHORD_REGEX
        line.scan(CHORD_REGEX) do |start, chord, finish|
          text_box start, at: [0, y], size: 10
          x += width_of(start, size: 10)
          text_box chord, at: [x, y_pos + 10], size: 10, style: :bold
          finish_box = text_box finish, at: [x, y_pos], size: 10
          x += [width_of(finish, size: 10), width_of(chord, size: 10) + 10].max
        end
      else
        text_box line, at: [0, y], size: 10
      end
    end
  end

end
