# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.ui-sortable').sortable()

  $('.mark-as-read-btn, .unfollow-btn').on 'click', (e) -> 
    inbox_container = $(e.target).parents('.inbox-container')
    group_div = $(e.target).parents('.inbox-group')
    list = $(e.target).parents('ul')
    row = $(e.target).parents('li')

    # remove the row for the item marked as read
    row.remove()

    # remove the whole inbox group if it is empty
    if list.find('li').length == 0
      group_div.remove()

    # put up inbox empty message if inbox is empty
    if inbox_container.find('.inbox-group').length == 0
      $('.inbox-empty-msg').show()
    

  #
  # Load discussion counts
  #

  discussion_css_class = '.discussion'

  # read all the discussion ids into a list
  discussion_ids = $.map $(discussion_css_class), (e) ->
    $(e).data('discussion-id')

  $.get '/discussions/activity_counts', {discussion_ids: discussion_ids}, (discussion_counts) ->
    i = 0
    $(discussion_css_class).each ->
      i = discussion_ids.indexOf($(this).data('discussion-id'))
      $(this).find('.activity-count').text(discussion_counts[i])

  $('.motion-sparkline').sparkline('html', { type: 'pie', height: '26px', width: '26px', sliceColors: [ "#90D490", "#F0BB67", "#D49090", "#dd0000", '#ccc'] })
  #
  # Load motion sparklines
  #
  #motion_css_class '.motion-icon'

  ## read all the motion ids into a list
  #motion_ids = $.map $(motion_css_class), (e) ->
    #$(e).data('motion-id')

  #$.get '/motions/vote_data', {motion_ids: motion_ids}, (motion_data) ->
    #i = 0
    #$(motion_css_class).each ->
      #i = motion_ids.indexOf($(this).data('motion-id'))
      #$(this).find('.motion-sparkline').sparkline(motion_data[i], type: 'pie')


  #
  # find times to be updated in javascript
  #
  $('.js-format-as-timeago').each ->
    time = moment($(this).data('time'))
    $(this).text(time.fromNow(true))
    
  #console.log(discussion_ids)

  #motion_ids = $.map $('.inbox-motion-icon'), (e) -> 
    #$(e).data('motion-id')



