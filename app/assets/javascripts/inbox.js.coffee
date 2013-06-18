# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.ui-sortable').sortable()

  $('a.mark-as-read-btn').on 'click', (e) -> 
    inbox_container = $(e.target).parents('.inbox-container')
    group_div = $(e.target).parents('.inbox-group')
    table = $(e.target).parents('table')
    row = $(e.target).parents('tr')

    # remove the row for the item marked as read
    row.remove()

    # remove the whole inbox group if it is empty
    if table.find('tr').length == 0
      group_div.remove()

    # put up inbox empty message if inbox is empty
    if inbox_container.find('.inbox-group').length == 0
      $('.inbox-empty-msg').show()


