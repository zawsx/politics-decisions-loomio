Feature: Mailchimp News
  As a user
  In order to be informed about loomio news activity when I want to be
  I want to control when loomio will send me news

  Scenario: User opts in to Loomio news during signs up
    Given I'm not a Loomio user
    When I visit the sign-up path
    And I fill in the sign-up form
    And I check "user_sibscribe_to_loomio_news"
    And click submit
    Then I should be subscribed to Loomio news

  Scenario: User disables Loomio news from email preferences
    Given I am a Loomio user
    And I am subscribed to Loomio news
    When I visit the email preferences page
    And I uncheck "email_preferences_subscribed_to_loomio_news"
    And I click "Update preferences"
    Then I should no longer be subscribed to the Loomio news

  Scenario: User receives a News email and clicks unsubscribe in the email
    Given I am a Loomio user
    And I am subscribed to Loomio news
    When I receive a Loomio news email
    And I click the "unsubscribe" link in the email
    Then I should no longer be subscribed to the Loomio news

  Scenario: Non-user receives a News email and clicks unsubscribe in the email
    Given I'm not a Loomio user
    And I am on the Mailchimp Loomio News list
    When I receive a Loomio news email
    And I click the "unsubscribe" link in the email
    Then I should no longer be subscribed to the Loomio news
