Given(/^the discussion has a proposal$/) do
  @motion = FactoryGirl.create :motion, discussion: @discussion, author: @user
  @group_member = FactoryGirl.create :user
  @group.add_member!(@group_member)
end

Given(/^I close the proposal$/) do
  visit discussion_path(@discussion)
  find('#close-voting').click
  find('#confirm-action').click
end

Given(/^I have recieved an email with subject "(.*?)"$/) do |arg1|
  last_email = ActionMailer::Base.deliveries.last
  last_email.subject.should include arg1
end

When(/^I click the link to create a proposal outcome$/) do
  open_email(@user.email, :with_subject => "Proposal closed")
  link = links_in_email(current_email)[2]
  request_uri = URI::parse(link).request_uri
  visit request_uri
end

# When(/^I see the proposal outcome field highlighted$/) do
#   page.should have_css "#outcome-input:focus"
# end

When(/^I specify a proposal outcome$/) do
  fill_in 'motion[outcome]', with: "Let's have an intervention about Rob's odooblem!"
end

Then(/^my group members should receive an email with subject "(.*?)"$/) do |arg1|
  last_email = ActionMailer::Base.deliveries.last
  last_email.subject.should =~ /arg1/
end

Given(/^I have created a proposal outcome$/) do
  @motion.outcome = "Let's have an intervention about Rob's odour Roblem!"
  find('#edit-outcome').click
end

When(/^I edit the proposal outcome$/) do
  fill_in '#outcome-input', with: "Let's have an intervention about Rob's odooblem!"
  click_on 'proposal-submit'
end

Then(/^my group members should not receive an email with subject "(.*?)"$/) do |arg1|
  last_email = ActionMailer::Base.deliveries.last
  last_email.subject.should_not =~ /arg1/
end
