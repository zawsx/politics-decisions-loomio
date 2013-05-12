Feature: Inbox Dropdown
  So I can easily read through the unread threads in my loomio groups
  I want to have an inbox dropdown menu
  That displays unread threads by group

  Scenario: User loads inbox page
    Given I am logged in member of a group with a new discussion
    When I load the inbox page
    Then I should see my group and the new discussion

  Scenario: User marks all discussions in group as read
    Given I am logged in member of a group with a new discussion
    When I load the inbox page
    And I click 'mark all as read'
    Then I should not see my group
  
