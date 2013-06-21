Feature: Search discussions and comments
  In order to find content in a pile of loomio disucssions
  As a user
  I need to search discussions and comments
  
  Background:
    Given I am logged in and belong to a group

  Scenario: Search matches but discussion is not in user's groups
    Given there is a discussion in another group titled "Pigs that fly"
    When I search for "pigs"
    Then I should not see the discussion title

  Scenario: User searches for discussion by title
    Given there is a discussion in my group titled "Pigs that fly"
    When I search for "pigs"
    Then I should see the discussion title

  Scenario: User searches for discussion by description
    Given there is a discussion with description "Hogs on a plane"
    When I search for "hogs"
    Then I should see the discussion title

  Scenario: User searches for discussion by comment content
    Given there is a discussion with a comment "That's a porky ham!"
    When I search for "porky"
    Then I should see the discussion title
