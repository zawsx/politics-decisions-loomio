angular.module('loomioApp').controller 'ProposalController', ($scope, $window, ProposalService) ->
  $scope.voteFormIsDisabled = false
  $scope.voteFormIsExpanded = false
  $scope.proposal =
    yes_votes_count: 0
    abstain_votes_count: 3
    no_votes_count: 1
    block_votes_count: 1
    votes_count: 5

  if $scope.proposal?
    $scope.newVote = {position: null, statement: null, proposal_id: $scope.proposal.id}

  $scope.selectPosition = (position) ->
    $scope.newVote.position = position
    $scope.voteFormIsExpanded = true

  $scope.submitVote = ->
    $scope.voteFormIsDisabled = true
    ProposalService.saveVote($scope.newVote, $scope.saveVoteSuccess, $scope.saveVoteError)

  $scope.saveVoteSuccess = (event) ->
    $scope.voteFormIsExpanded = false
    $scope.voteFormIsDisabled = false
    $scope.currentUserVote = event.eventable

  $scope.saveVoteError = (error) ->
    $scope.voteFormIsDisabled = false
    $scope.voteErrorMessages = error.messages

  $scope.getScreenWidth = () ->
    $(window).width()

  $window.onresize = () ->
    $scope.$apply()
