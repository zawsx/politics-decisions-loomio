require 'spec_helper'

describe Queries::UnreadDiscussions do
  let(:user) { create :user }
  let(:group) { create :group }
  let(:discussion) { create(:discussion, group: group) }

  describe ".for(user, group)" do
    context "discussion has not been viewed" do
      it "returns discussion" do
        Queries::UnreadDiscussions.for(user, group).should include(discussion)
      end
    end

    context "discussion has been viewed" do
      it "does not return discussion" do
        ViewLogger.discussion_viewed(discussion, user)
        Queries::UnreadDiscussions.for(user, group).should_not include(discussion)
      end
    end

    context "discussion has been viewed but there is a new comment" do
      it "returns discussion" do
        ViewLogger.discussion_viewed(discussion, user)
        discussion.add_comment(user, "hi", false)
        Queries::UnreadDiscussions.for(user, group).should_not include(discussion)
      end
    end
  end
end
