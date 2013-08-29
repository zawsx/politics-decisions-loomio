Then(/^I should see a link to sign in with google$/) do
  page.should have_content("Log in with Google")
end

Then(/^I see a link to create an account$/) do
  page.should have_css("#create_account")
end
