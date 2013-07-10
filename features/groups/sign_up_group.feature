Feature: Sign up new group
  In order to bring my group onto Loomio
  As a group coordinator
  I want to create a new group

Scenario: New user creates subscripton group
  Given I am on the home page of the website
  When I click the start new group button
  And I click the subscription button
  And I fill in and submit the form
  Then the group is created
  And I should see the thank you page
  And I should recieve an email with an invitation link
  When I click the invitation link
  And I sign up as a new user
  And I should see the group page
  And I should be added to the group as a coordinator

Scenario: Logged in existing user creates subscripton group
  Given I am logged in
  When I click on the start new group link in the group dropdown
  And I click the subscription button
  When I fill in the group name and submit the form
  Then the group is created
  And I should see the thank you page
  And I should recieve an email with an invitation link
  When I click the invitation link
  And I should see the group page
  And I should be added to the group as a coordinator

Scenario: Logged out existing user creates subscripton group
  Given I am on the home page of the website
  When I click the start new group button
  And I click the subscription button
  And I fill in and submit the form
  Then the group is created
  And I should see the thank you page
  And I should recieve an email with an invitation link
  When I click the invitation link
  And I sign in via the sign up page
  And I should see the group page
  And I should be added to the group as a coordinator

Scenario: New user creates Pay What You Can group
  Given I am on the home page of the website
  When I click the start new group button
  And I click the pay what you can button
  And I fill in and submit the form
  Then the group is created
  And I should see the thank you page
  And I should recieve an email with an invitation link
  When I click the invitation link
  And I sign up as a new user
  Then the group is created
  And I should see the group page with a contribute link
  And I should be added to the group as a coordinator

Scenario: Logged in existing user creates Pay What You Can group
  Given I am logged in
  When I click on the start new group link in the group dropdown
  And I click the pay what you can button
  And I fill in the group name and submit the form
  Then the group is created
  And I should see the thank you page
  And I should recieve an email with an invitation link
  When I click the invitation link
  And I should see the group page with a contribute link
  And I should be added to the group as a coordinator

Scenario: Logged out existing user creates Pay What You Can group
  Given I am on the home page of the website
  When I click the start new group button
  And I click the pay what you can button
  And I fill in and submit the form
  Then the group is created
  And I should see the thank you page
  And I should recieve an email with an invitation link
  When I click the invitation link
  And I sign in via the sign up page
  And I should see the group page with a contribute link
  And I should be added to the group as a coordinator
