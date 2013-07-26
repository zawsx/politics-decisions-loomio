class CalculateReadCommentsCount < ActiveRecord::Migration
  def up
    add_column :discussion_read_logs, :read_comments_count, :integer

    DiscussionReadLog.reset_column_information

    DiscussionReadLog.find_each do |log|
      if log.discussion.present?
        count = log.discussion.comments.where('updated_at <= ?', log.discussion_last_viewed_at).count
        log.update_attribute(:read_comments_count, count)
      end

      if log.id % 100 == 0
        puts log.id
      end
    end

  end

  def down
    remove_column :discussion_read_logs, :read_comments_count
  end
end
