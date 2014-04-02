$ ->
  $("#privacy").tooltip
    placement: "right"

# adds bootstrap popovers to group activity indicators
activate_discussions_tooltips = () ->
  $(".unread-group-activity").tooltip
    placement: "top"
    title: 'There have been new comments on this discussion since you last visited the group.'

$ ->
  disable = ($el) ->
    $el.prop('disable', true)
    $el.parent().addClass('disabled')

  check = ($el) ->
    $el.prop('checked', true)

  set_private_discussions_only = ->
    #check private discussions only
    check $('#group_discussion_privacy_private_only')
    #disable other privacy choices
    disable $('#group_discussion_privacy_public_or_private,
               #group_discussion_privacy_public_only')

  set_public_discussions_only = ->
    #check public discussions only
    check $('#group_discussion_privacy_public_only')
    #disable other privacy choices
    disable $('#group_discussion_privacy_public_or_private,
               #group_discussion_privacy_private_only')

  set_invitation_only = ->
    #check invitation only
    check $('#group_membership_granted_upon_invitation')
    # disable other invitation choices
    disable $('#group_membership_granted_upon_request,
               #group_membership_granted_upon_approval')

  set_members_can_add_members_only = ->
    check $('#group_members_can_add_members_true')
    disable $('#group_members_can_add_members_false')

  update_group_form_state = ->
    #undisable everything
    $('form.new_group input, form.edit_group input').prop('disabled', false)
    $('form.new_group label, form.edit_group label').removeClass('disabled')

    if $('#group_visible_false').is(':checked')
      set_invitation_only()
      set_private_discussions_only()

    if $('#group_visible_true').is(':checked')
      #if anyone can join
      if $('#group_membership_granted_upon_request').is(':checked')
        set_public_discussions_only()
        set_members_can_add_members_only()

  $('form.new_group, form.edit_group').on 'change', ->
    update_group_form_state()
