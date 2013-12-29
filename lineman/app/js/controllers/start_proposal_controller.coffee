angular.module('loomioApp').controller 'StartProposalController', ($scope, ProposalService) ->
  $scope.isExpanded = false

  $scope.expand = ->
    $scope.isExpanded = true

  $scope.collapseIfEmpty = ->
    if ($scope.commentField.val().length == 0)
      $scope.isExpanded = false
