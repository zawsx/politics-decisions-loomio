describe UnreadDiscussionsByGroup do
  # last time discussion was read
  # date of last activity for discussion

  let(:user) {stub(:user)}

  context 'user with no groups' do
    let(:groups) {[]}
    it 'returns empty results' do
      results = UnreadDiscussionsByGroup.for(user, groups)
      results.should be_empty
    end
  end


  context 'user with a group' do
    let(:groups){[group]}
    let(:group){stub(:group, discussions: [discussion], id: 1)}

    context 'new discussion in group' do
      let(:discussion){stub(:discussion, 
                            id: 1,
                            last_looked_at_by: nil,
                            latest_comment_time: 1.day.ago)}
      it 'returns the new discussion' do
        results = UnreadDiscussionsByGroup.for(user, groups)
        results[group.id][:unread_discussions].should == [discussion]
      end
    end

    context 'new comment in discussion' do
      let(:discussion){stub(:discussion, 
                            id: 1, 
                            last_looked_at_by: 2.days.ago,
                            latest_comment_time: 1.day.ago)}
      it 'returns teh discussion with new comment' do
        results = UnreadDiscussionsByGroup.for(user, groups)
        results[group.id][:unread_discussions].should == [discussion]
      end
    end

    context 'two unread discussions' do
      let(:group){stub(:group, 
                       discussions: [discussion_1, discussion_2], 
                       id: 1)}

      let(:discussion_1){stub(:discussion, 
                            id: 1,
                            last_looked_at_by: 2.days.ago,
                            latest_comment_time: 1.day.ago)}

      let(:discussion_2){stub(:discussion, 
                            id: 2,
                            last_looked_at_by: 2.days.ago,
                            latest_comment_time: 1.day.ago)}

      it 'returns both discussions' do
        results = UnreadDiscussionsByGroup.for(user, groups)
        results[group.id][:unread_discussions].should == [discussion_1, discussion_2]
      end

      it 'returns last_read_at\'s' do
        results = UnreadDiscussionsByGroup.for(user, groups)
        results [group.id][:last_read_times][discussion_1.id].should == discussion_1.last_looked_at_by
        results [group.id][:last_read_times][discussion_2.id].should == discussion_2.last_looked_at_by
      end
    end
  end

end
