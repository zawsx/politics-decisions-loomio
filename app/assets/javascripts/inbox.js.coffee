# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$ ->
  $('a.inbox-select-all-in-group').on 'click', (e) ->
    e.preventDefault()
    $(this).parent().parent().find('input[type=checkbox].mark-as-read-cb').attr('checked', 'checked')

  $('a.inbox-unselect-all-in-group').on 'click', (e) ->
    e.preventDefault()
    $(this).parent().parent().find('input[type=checkbox].mark-as-read-cb').attr('checked', false)
