$ ->
  $("#privacy").tooltip
    placement: "right"

# adds bootstrap popovers to group activity indicators
activate_discussions_tooltips = () ->
  $(".unread-group-activity").tooltip
    placement: "top"
    title: 'There have been new comments on this discussion since you last visited the group.'

$ ->
  $('form.new_group, form.edit_group').on 'change', ->
    # if $('#group_visible_false') is chosen
    # then select invite only and disable join options
    # and select private discssions only and disable privacy options
    # and show 'who can add members?'
