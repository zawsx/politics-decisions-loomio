Feature: Proposals
  Scenario: Starting a proposal
    Given I am signed in, viewing a new discussion
    When I click 'Start a proposal'
    And I fill in the proposal form
    And click 'Create proposal'
    Then my proposal should be the current proposal

  Scenario: Extending a proposal
  Scenario: Closing a proposal
