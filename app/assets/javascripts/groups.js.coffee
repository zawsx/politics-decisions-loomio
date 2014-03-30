$ ->
  $("#privacy").tooltip
    placement: "right"

# adds bootstrap popovers to group activity indicators
activate_discussions_tooltips = () ->
  $(".unread-group-activity").tooltip
    placement: "top"
    title: 'There have been new comments on this discussion since you last visited the group.'

$ ->
  set_private_discussions_only = ->
    #check private discussions only
    $('#group_discussion_privacy_private_only').prop('checked', true)
    #disable other privacy choices
    $('#group_discussion_privacy_public_or_private').prop('disabled', true)
    $('#group_discussion_privacy_public_only').prop('disabled', true)

  set_public_discussions_only = ->
    #check public discussions only
    $('#group_discussion_privacy_public_only').prop('checked', true)
    #disable other privacy choices
    $('#group_discussion_privacy_public_or_private').prop('disabled', true)
    $('#group_discussion_privacy_private_only').prop('disabled', true)

  set_invitation_only = ->
    #check invitation only
    $('#group_membership_granted_upon_invitation').prop('checked', true)
    # disable other invitation choices
    $('#group_membership_granted_upon_request').prop('disabled', true)
    $('#group_membership_granted_upon_approval').prop('disabled', true)

  hide_who_can_add_members = ->
    #hide who can add members?
    $('.group_members_can_add_members').hide()

  update_group_form_state = ->
    #undisable everything
    $('form.new_group input, form.edit_group input').prop('disabled', false)
    $('.group_members_can_add_members').show()

    if $('#group_visible_false').is(':checked')
      set_invitation_only()
      set_private_discussions_only()

    if $('#group_visible_true').is(':checked')
      #if anyone can join
      if $('#group_membership_granted_upon_request').is(':checked')
        set_public_discussions_only()
        hide_who_can_add_members()

      if $('#group_membership_granted_upon_invitation').is(':checked')
        set_private_discussions_only()

  $('form.new_group, form.edit_group').on 'change', ->
    update_group_form_state()
