Feature: Coordinator creates proposal outcome
  As a proposal author
  I want to share the outcome of the proposal with other group members
  So that the group is informed of the outcome of a proposal and members can act on the decisions

  Background:
    Given I am logged in
    And I am an admin of a group
    And there is a discussion in the group
    And the discussion has a proposal

  @javascript
  Scenario: Coordinator creates a proposal outcome
    Given I close the proposal
    And I have recieved an email with subject "Proposal closed"
    When I click the link to create a proposal outcome
#    And I see the proposal outcome field highlighted
    And I specify a proposal outcome
    And I click "Publish outcome"
    Then my group members should receive an email with subject "Proposal outcome"

  Scenario: Coordinator edits a proposal outcome
    Given I close the proposal
    And I have created a proposal outcome
    When I edit the proposal outcome
    And I click "Save"
    Then my group members should not receive an email with subject "Proposal outcome"
