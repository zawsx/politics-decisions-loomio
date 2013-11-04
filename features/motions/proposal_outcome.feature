Feature: Coordinator creates proposal outcome
  As a Loomio group coordinator
  So I can communicate to my group the results of a proposal
  I want to be able to create a proposal outcome

  Background:
    Given I am logged in
    And I am an admin of a group
    And there is a discussion in the group
    And the discussion has a closed proposal

  Scenario: Coordinator creates a proposal outcome
    And I have recieved an email with subject "Proposal closed"
    When I click the link to create a proposal
    And I specify a proposal
    And I click "Publish outcome"
    Then my group members should receive an email with subject "Proposal outcome"

  Scenario: Coordinator edits a proposal outcome
    And I have created a proposal outcome
    When I edit the propsosal outcome
    And I click "Save"
    Then my group members should not receive an email with subject "Proposal outcome"
