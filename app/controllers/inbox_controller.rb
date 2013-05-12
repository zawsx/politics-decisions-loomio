class InboxController < BaseController
  def index
    @groups = current_user.groups.sort{|a,b| a.full_name <=> b.full_name}
    @unread_discussions_by_group = UnreadDiscussionsByGroup.for(current_user, 
                                                                @groups)
  end

  def mark_as_read
    params[:discussion_ids].each do |discussion_id|
      discussion = Discussion.find(discussion_id)
      ViewLogger.discussion_viewed(discussion, current_user)
    end
    redirect_to inbox_path
  end
end
