Given(/^I am logged in and belong to a group$/) do
  step 'I am logged in'
  @group = FactoryGirl.create(:group)
  @group.add_member!(@user)
end

Given(/^there is a discussion in another group titled "(.*?)"$/) do |arg1|
  @discussion = FactoryGirl.create(:discussion, title: arg1)
end

Given(/^there is a discussion in my group titled "(.*?)"$/) do |arg1|
  @discussion = FactoryGirl.create(:discussion, title: arg1, group: @group)
end

When(/^I search for "(.*?)"$/) do |arg1|
  visit new_search_path
  fill_in 'Query', with: arg1
  click_on 'Search'
end

Then(/^I should see the discussion title$/) do
  page.should have_content @discussion.title
end

Then(/^I should not see the discussion title$/) do
  page.should_not have_content @discussion.title
end

Given(/^there is a discussion with description "(.*?)"$/) do |arg1|
  @discussion = FactoryGirl.create(:discussion, description: arg1, group: @group)
end

Given(/^there is a discussion with a comment "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
