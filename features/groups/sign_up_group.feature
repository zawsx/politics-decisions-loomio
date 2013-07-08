Feature: Sign up new group
  In order to bring my group onto Loomio
  As a group coordinator
  I want to create a new group

Scenario: New user creates subscripton group
  Given I am on the home page of the website
  When I click the start new group button
  Then I should see the group selection page
  When click the subscription button
  And I fill in and submit the subscription form
  Then I should see the thank you page
  And I should recieve an invitation email to start the group
  When I click the invitation link
  And I sign up as a new user
  Then the group should be created
  And I should see the group page
  And I should be added to the group as a coordinator

Scenario: Logged in existing user creates subscripton group
  Given I am logged in
  When I click on the start new group link in the group dropdown
  Then I should see the group selection page
  When click the subscription button
  And I should see my name and email in the form
  And I fill in the group name submit the subscription form
  Then I should see the thank you page
  And I should recieve an invitation email to start the group
  When I click the invitation link
  Then the group should be created
  And I should see the group page
  And I should be added to the group as a coordinator

Scenario: Logged out existing user creates subscripton group
  Given I am on the home page of the website
  When I click the start new group button
  Then I should see the group selection page
  When click the subscription button
  And I fill in and submit the subscription form
  Then I should see the thank you page
  And I should recieve an invitation email to start the group
  When I click the invitation link
  And I sign in
  Then the group should be created
  And I should see the group page
  And I should be added to the group as a coordinator

Scenario: New user creates Pay What You Can group
  Given I am on the home page of the website
  When I click the start new group button
  Then I should see the group selection page
  When I click the pay what you can button
  And I fill in and submit the subscription form
  Then I should see the thank you page
  And I should recieve an invitation email to start the group
  When I click the invitation link
  And I sign up as a new user
  Then the group should be created
  And I should see the group page with a contribute link
  And I should be added to the group as a coordinator

Scenario: Logged in existing user creates Pay What You Can group
  Given I am logged in
  When I click on the start new group link in the group dropdown
  Then I should see the group selection page
  When I click the pay what you can button
  And I fill in and submit the subscription form
  Then I should see the thank you page
  And I should recieve an invitation email to start the group
  When I click the invitation link
  Then the group should be created
  And I should see the group page with a contribute link
  And I should be added to the group as a coordinator

Scenario: Logged out existing user creates Pay What You Can group
  Given I am on the home page of the website
  When I click the start new group button
  Then I should see the group selection page
  When I click the pay what you can button
  And I fill in and submit the subscription form
  Then I should see the thank you page
  And I should recieve an invitation email to start the group
  When I click the invitation link
  And I sign in
  Then the group should be created
  And I should see the group page with a contribute link
  And I should be added to the group as a coordinator
