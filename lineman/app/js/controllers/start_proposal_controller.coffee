angular.module('loomioApp').controller 'StartProposalController', ($scope, ProposalService) ->
  $scope.isExpanded = false

  $scope.showForm = ->
    $scope.isExpanded = true

  $scope.collapseIfEmpty = ->
    if ($scope.commentField.val().length == 0)
      $scope.isExpanded = false
