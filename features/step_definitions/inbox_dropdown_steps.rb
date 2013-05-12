Given(/^I am logged in member of a group with a new discussion$/) do
  @user = FactoryGirl.create(:user)
  @group = FactoryGirl.create(:group)
  @group.add_member! @user
  @unread_discussion = FactoryGirl.create(:discussion, group: @group)
  login_automatically @user
end

When(/^I load the inbox page$/) do
  visit inbox_path
end

Then(/^I should see my group and the new discussion$/) do
  page.should have_content 'Inbox'
  page.should have_content @group.name
  page.should have_content @unread_discussion.title
end

When(/^I click 'mark all as read'$/) do
  click_on 'Mark all as read'
end

Then(/^I should not see my group$/) do
  page.should have_no_content @group.name
end
