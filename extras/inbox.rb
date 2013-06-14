class Inbox
  def initialize(user)
    @user = user
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
    @user.groups
  end

  def unread_discussions_for(group)
    Queries::UnreadDiscussions.for(@user, group)
  end

  def unvoted_motions_for(group)
    Queries::UnvotedMotions.for(@user, group)
  end
end
