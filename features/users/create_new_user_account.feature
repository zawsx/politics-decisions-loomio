Feature: Create new user account
  As a new user signing up to loomio,
  I want to be able create an account with the right settings
  So that future Loomio use is right for me

  Scenario: User signs up and opts out of Loomio News
    When I visit the sign-up path
    And I fill in the sign-up form
    And I check "user_sibscribe_to_loomio_news"
    And click submit
    Then I should be subscribed to loomio news
