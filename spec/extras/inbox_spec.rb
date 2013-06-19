require 'spec_helper'

describe Inbox do
  context '#unread_discussions_for(group)' do
    let(:user) {FactoryGirl.create(:user)}

    subject do
      inbox = Inbox.new(user)
      inbox.load
      inbox
    end
  end

  context '#unfollow' do
    let(:discussion){FactoryGirl.create(:discussion)}
    let(:user){FactoryGirl.create(:user)}
    it 'calls ViewLogger#discussion_unfollowed' do
      ViewLogger.should_receive(:discussion_unfollowed).with(discussion, user)
    end
  end
end
