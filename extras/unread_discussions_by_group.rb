class UnreadDiscussionsByGroup
  def self.for(user, groups)
    results = {}
    groups.each do |group|
      unread_discussions = []
      last_read_times = {}
      group.discussions.each do |discussion|
        last_read_at = discussion.last_looked_at_by(user)
        last_updated_at = discussion.latest_comment_time

        if last_read_at.nil? || (last_read_at < last_updated_at)
          unread_discussions << discussion
          last_read_times[discussion.id] = last_read_at
        end
      end

      if unread_discussions.present?
        results[group.id] = { unread_discussions: unread_discussions,
                              last_read_times: last_read_times }
      end
    end
    results
  end
end
