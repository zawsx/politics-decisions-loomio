When(/^I click on the start new group link in the group dropdown$/) do
  find(".new-group a").click
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

When(/^I click the subscription button$/) do
  find("#organisation a").click
end

When(/^I fill in and submit the subscription form$/) do
  @name = "Herby's Erbs"
  fill_in :group_request_admin_name, with: "Herby Hancock"
  fill_in :group_request_admin_email, with: "herb@home.com"
  fill_in :group_request_name, with: @name
  click_on 'Sign up'
end

Then(/^I should see the thank you page$/) do
  page.should have_css("body.group_requests.confirmation")
end

Then (/^the group is created$/) do
  @group = Group.where(name: @name).first
  @group_request = @group.group_request
end

When(/^I click the invitation link$/) do
  link = links_in_email(current_email)[2]
  request_uri = URI::parse(link).request_uri
  visit request_uri
  # click_email_link_matching(invitation_url(@group_request.token))
end

Then(/^I should see the group page$/) do
  page.should have_css("body.groups.show")
end

Then(/^I should be added to the group as a coordinator$/) do
  @user = User.find_by_email(@group.admin_email)
  @user.adminable_groups.should include @group
end

When(/^I click the pay what you can button$/) do
  find("#informal-group a").click
end

Then(/^I should see the group page with a contribute link$/) do
  page.should have_css("body.groups.show")
  page.should have_css("#contribute")
end

When(/^I fill in the group name submit the subscription form$/) do
  fill_in :group_request_name, with: "Hermans Herbs"
  click_on 'Sign up'
end
