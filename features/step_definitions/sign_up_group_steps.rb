When(/^I click on the start new group link in the group dropdown$/) do
  click_on "Start a group"
end

Then(/^I should see the group selection page$/) do
  page.should have_content("body.group_sign_up.new")
end

Then(/^I should see my name and email in the form$/) do
  find('#group_request_admin_name').should have_content(@user.name)
end

Given(/^I am on the home page of the website$/) do
  visit '/'
end

When(/^I click the start new group button$/) do
  click_on "start-group-btn"
end

Given(/^I am on the group selection page$/) do
  page.should have_content("body.group_sign_up.new")
end

When(/^click the subscription button$/) do
  find("#organisation a").click
end

When(/^I fill in and submit the subscription form$/) do
  fill_in :group_request_admin_name, with: "Herby Hancock"
  fill_in :group_request_admin_email, with: "herb@home.com"
  fill_in :group_request_name, with: "Herby's Erbs"
  click_on 'Sign up'
end

Then(/^I should see the thank you page$/) do
  page.should have_content("body.group_sign_up.thanks")
end

Then(/^I should recieve an invitation email to start the group$/) do
  pending# express the regexp above with the code you wish you had
end

When(/^I click the invitation link$/) do
  click_on 'Get in touch'
end

Then(/^I should see the group page$/) do
  page.should have_content("body.groups.show")
end

Then(/^I should be added to the group as a coordinator$/) do
  @user.adminable_groups.should include @group
end

When(/^I click the pay what you can button$/) do
  find("#informal-group a").click
end

Then(/^I should see the group page with a contribute link$/) do
  page.should have_content("body.groups.show")
  page.should have_css("#contribute")
end

When(/^I fill in the group name submit the subscription form$/) do
  fill_in :group_request_name, with: "Hermans Herbs"
  click_on 'Sign up'
end
