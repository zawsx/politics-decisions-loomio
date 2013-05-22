class MotionMailer < ActionMailer::Base
  include ApplicationHelper
  include ERB::Util
  include ActionView::Helpers::TextHelper
  default :from => "\"Loomio\" <noreply@loomio.org>", :css => :email

  def new_motion_created(motion, user)
    @user = user
    @motion = motion
    @group = motion.group
    @rendered_motion_description = render_rich_text(motion.description, false) #should replace false with motion.uses_markdown in future
    mail( to: user.email,
          reply_to: motion.author_email,
          subject: "#{email_subject_prefix(@group.full_name)} New proposal - #{@motion.name}")
  end

  def motion_closed(motion, email)
    @motion = motion
    @group = motion.group
    mail( to: email,
          reply_to: "noreply@loomio.org",
          subject: "#{email_subject_prefix(@group.full_name)} Proposal closed - #{@motion.name}")
  end

  def motion_blocked(vote)
    @vote = vote
    @user = vote.user
    @motion = vote.motion
    @discussion = @motion.discussion
    @group = @motion.group
    @rendered_motion_description = render_rich_text(@motion.description, false) #should replace false with motion.uses_markdown in future
    mail( to: @motion.author_email,
          reply_to: @group.admin_email,
          subject: "#{email_subject_prefix(@group.full_name)} Proposal blocked - #{@motion.name}")
  end
end
