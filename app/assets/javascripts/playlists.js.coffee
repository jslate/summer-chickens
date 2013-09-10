$ ->
  $('#add-song-form').on 'ajax:success', (event, data) ->
    $('.playlist-songs').append("<li>#{data.song.title} <a href=\"/playlists/#{data.playlist}/remove_song?song=#{data.song.id}\" data-remote=\"true\" data-method=\"post\" class=\"remove\">remove</a></li>")
    $("#add-song-form select option[value=#{data.song.id}]").remove()

  $('.playlist-songs').on 'ajax:success', 'a.remove', (event, data) ->
    $(event.currentTarget).closest('li').remove()
    $('#add-song-form select').append("<option value=\"#{data.song.id}\">#{data.song.title}</a>")

