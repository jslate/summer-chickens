# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#add-song-form').on 'ajax:success', (event, data) ->
    $('.playlist-songs').append("<li>#{data.song.title}</li>")
    $("#add-song-form select option[value=#{data.song.id}]").remove()