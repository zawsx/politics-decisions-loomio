class DiscussionItems::MotionOutcome < DiscussionItem
  attr_reader :event, :motion

  def initialize(event, motion)
    @event, @motion = event, motion
  end

  def icon
    'proposal-icon'
  end

  def actor
    motion.author
  end

  def group
    motion.group
  end

  def header
    I18n.t('discussion_items.motion_outcome')
  end

  def body
    " #{motion.name}"
  end

  def time
    event.created_at
  end
end