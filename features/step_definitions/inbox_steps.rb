When(/^I visit the inbox$/) do
  visit inbox_path
end

Given(/^I belong to a group with a discussion$/) do
  @discussion = FactoryGirl.create(:discussion)
  @group = @discussion.group
  @group.add_member!(@user)
end

When(/^I click to view the discussion$/) do
  click_on(@discussion.title)
end

When(/^I visit the inbox again$/) do
  step 'I visit the inbox'
end

Then(/^the inbox should be empty$/) do
  page.should have_content(I18n.t(:"inbox.empty"))
end

Then(/^I should see the unread discussion$/) do
  page.should have_content(@discussion.title)
end

Given(/^I belong to a group with a motion$/) do
  @motion = FactoryGirl.create(:motion)
  @group = @motion.group
  @group.add_member!(@user)
end

Then(/^I should see the motion$/) do
  page.should have_content(@motion.title)
end

When(/^I have voted on the motion$/) do
  ViewLogger.discussion_viewed(@motion.discussion, @user)
  vote = Vote.new(position: "yes")
  vote.motion = @motion
  vote.user = @user
  vote.save!
end

When(/^I mark the discussion as read$/) do
  save_and_open_page
  click_on 'mark as read'
end

Then(/^the discussion should disappear$/) do
  page.should_not have_content @discussion.title
end
