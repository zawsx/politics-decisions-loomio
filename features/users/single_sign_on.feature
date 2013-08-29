Feature: Single sign-on
  As a Loomio user
  So that I can easily sign in
  I would like to use other accounts as authentication

  Scenario: See sign in links
    Given I am a logged out user
    When I visit the sign in page
    Then I should see a link to sign in with google
    And I see a link to create an account
