class Queries::UnreadDiscussions
  def self.for(user, group)
    group.
      discussions.
      joins('LEFT OUTER JOIN discussion_read_logs drl ON
            drl.discussion_id = discussions.id').
      where('(drl.user_id = ? AND
            drl.discussion_last_viewed_at < discussions.last_comment_at)
            OR drl.discussion_id IS NULL', user.id)
  end
end
