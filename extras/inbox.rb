class Inbox
  def initialize(user)
    @user = user
  end

  def mark_as_read!(class_name, id)
    if class_name.to_s == 'Discussion'
      item = Discussion.find id
    end

    if @user.can? :index, item
      ViewLogger.discussion_viewed(item, @user)
    end

  end

  def load
    @grouped_items = {}
    groups.each do |group|
      discussions = unread_discussions_for(group)
      motions = unvoted_motions_for(group)
      next if discussions.empty? && motions.empty?
      @grouped_items[group] = motions + discussions
    end
    self
  end

  def empty?
    @grouped_items.empty?
  end

  def items_by_group
    @grouped_items.each_pair do |group, discussions|
      yield group, discussions
    end
  end

  def groups
    @user.memberships.where('inbox_position is not null').order(:inbox_position).map(&:group)
  end

  def unread_discussions_for(group)
    Queries::UnreadDiscussions.for(@user, group)
  end

  def unvoted_motions_for(group)
    Queries::UnvotedMotions.for(@user, group)
  end
end
