class Groups::InvitationsController < GroupBaseController
  before_filter :require_current_user_can_invite_people
  before_filter :ensure_invitations_available, only: [:new, :create]

  def new
    @invite_people = InvitePeople.new
    load_decorated_group
  end

  def create
    # get all the emails
    @emails = params[:invite_people][:recipients].split(',')

    # figure out people who we should auto-add
    existing_users = User.where(email: @emails)
    users_not_in_group = existing_users - @group.members.all
    @users_in_group = existing_users - users_not_in_group

    # auto-add users_not_in the group
    users_not_in_group.each do |user|
      @group.add_member!(user)
    end
    @num_auto_added = users_not_in_group.count

    # emails to send invites to (not yet users)
    new_emails = @emails - existing_users.pluck(:email)

    @invite_people = InvitePeople.new(params[:invite_people])
    @invite_people.recipients = new_emails.join(',')

    #check if there are people to invite by email. if there are, do it and set flash
    if @invite_people.valid?
      @num_invited = CreateInvitation.to_people_and_email_them(@invite_people, group: @group, inviter: current_user)
      set_invitation_success_flash
      redirect_to group_path(@group)
    #there was nooone to invite... was there anyone auto-added?
    elsif existing_users.count > 0 #@num_auto_added > 0 || @users_in_group.count > 0
      set_invitation_success_flash
      redirect_to group_path(@group)
    else
      load_decorated_group
      render :new
    end
  end

  def index
    @pending_invitations = @group.pending_invitations
    load_decorated_group
  end

  def destroy
    load_invitation
    @invitation.cancel!(canceller: current_user)
    redirect_to group_invitations_path(@group), notice: "Invitation to #{@invitation.recipient_email} cancelled"
  end

  private

  def ensure_invitations_available
    unless @group.invitations_remaining > 0
      render 'no_invitations_left'
    end
  end

  def load_invitation
    @invitation = @group.pending_invitations.find(params[:id])
  end

  def load_decorated_group
    @group = GroupDecorator.new(Group.find(params[:group_id]))
  end

  def set_invitation_success_flash
    if @num_auto_added == 0 && @num_invited > 0 #only invites were sent
      flash[:notice] = t(:'notice.invitations.sent', count: @num_invited)
    elsif @num_auto_added > 0 && @num_invited == 0 #only users were auto-added
      if @emails.count == @users_in_group.count #there were only existing members in the emails given
        flash[:notice] = t(:'notice.invitations.existing_member', count: @users_in_group.count)
      else #only users were auto-added
        flash[:notice] = t(:'notice.invitations.auto_added', count: @num_auto_added)
      end
    else #a mix of users and new people were invited (and maybe existing members)
      flash[:notice] = t(:'notice.invitations.auto_added_and_sent',
                            auto_added_text: t(:'notice.invitations.auto_added', count: @num_auto_added),
                            sent_text: t(:'notice.invitations.sent', count: @num_invited))
      # flash[:notice] = t(:'notice.invitations.auto_added_and_sent', num_added: @num_auto_added, num_invited: @num_invited)
    end

    #rewrite

    # if #there were only existing members in the emails given (nothing happened)
    #   # WARNING
    # elsif #only users were auto-added

    # elsif #only people were invited by email

    # else  #(a mix of auto-add and invites)

    # end

  end
end
