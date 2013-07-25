class Events::UserAddedToGroup < Event
  after_create :notify_users!

  def self.publish!(membership)
    create!(:kind => "user_added_to_group", :eventable => membership)
  end

  def membership
    eventable
  end

  private

  def notify_users!
    notify!(membership.user)
    UserMailer.delay.group_membership_approved(membership.user, membership.group)
  end

  handle_asynchronously :notify_users!
end
