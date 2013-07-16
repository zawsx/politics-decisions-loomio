Given(/^there is a discussion in another group titled "(.*?)"$/) do |title|
	@other_group = FactoryGirl.create :group
	@other_discussion = FactoryGirl.create :discussion, group: @other_group, title: title
end

Given(/^I am logged in and belong to a group$/) do
  step %{I am logged in}
  @group = FactoryGirl.create :group
  @group.add_member!(@user)
end

When(/^I search for "(.*?)"$/) do |search_item|
	visit search_path(query: search_item)
end

Then(/^I should not see the discussion title$/) do
	page.should_not have_content(@other_discussion.title)
end

Given(/^there is a discussion in my group titled "(.*?)"$/) do |title|
  @discussion = FactoryGirl.create :discussion, group: @group, title: title
end

Then(/^I should see the discussion title$/) do
  page.should have_content(@discussion.title)
end
