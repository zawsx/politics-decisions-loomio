require 'spec_helper'
describe InboxPreferencesForm do

  def create_membership_with_position(user, group, position = 0)
    membership = Membership.new
    membership.group = group
    membership.user = user
    membership.inbox_position = position
    membership.access_level = 'member'
    membership.save!
    membership
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:group) { FactoryGirl.create(:group) }
  subject { InboxPreferencesForm.new(user) }

  context "retreving" do
    describe '#groups' do
      it 'returns empty array if user has no memberships' do
        subject.groups.should == []
      end

      it 'returns id of group selected to appear in inbox' do
        group.add_member!(user)
        subject.groups.should include group
      end

      it 'returns groups ordered by position' do
        red_group = FactoryGirl.create(:group)
        blue_group = FactoryGirl.create(:group)
        m1 = create_membership_with_position(user, red_group, 1)
        m0 = create_membership_with_position(user, blue_group, 0)
        subject.groups.should == [m0.group, m1.group]
      end
    end
  end

  context '#submit' do
    it 'records the order you want your groups' do
      red_group = FactoryGirl.create(:group)
      blue_group = FactoryGirl.create(:group)
      m1 = create_membership_with_position(user, red_group, 5)
      m0 = create_membership_with_position(user, blue_group, 6)
      subject.submit({groups: [m0.group_id, m1.group_id]})
      m0.reload.inbox_position.should == 0
      m1.reload.inbox_position.should == 1
    end

    it 'removes groups you dont want to see' do
      red_group = FactoryGirl.create(:group)
      m0 = create_membership_with_position(user, red_group, 6)
      subject.submit({groups: []})
      m0.reload.inbox_position.should == nil
    end
  end


end
