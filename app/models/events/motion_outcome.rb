class Events::MotionOutcome < Event
  after_create :notify_users!

  def self.publish!(motion)
    create!(:kind => "motion_outcome", :eventable => motion,
                      :discussion_id => motion.discussion.id)
  end

  def motion
    eventable
  end

  private

  def notify_users!
    motion.group_users_without_motion_author.each do |user|
      if user.email_notifications_for_group?(motion.group)
        MotionMailer.delay.motion_outcome(motion, user)
      end
      #notify!(user)
    end
  end

  handle_asynchronously :notify_users!
end