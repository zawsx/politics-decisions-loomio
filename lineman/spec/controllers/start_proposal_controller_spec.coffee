describe 'StartProposal Controller', ->
  parentScope = null
  $scope = null
  controller = null

  mockProposalService =
    start: (proposal) ->
      true

  beforeEach module 'loomioApp'

  beforeEach inject ($rootScope, $controller) ->
    parentScope = $rootScope
    $scope = $rootScope.$new()
    controller = $controller 'StartProposalController',
      $scope: $scope
      ProposalService: mockProposalService

  it 'should start collapsed', ->
    expect($scope.isExpanded).toBe(false)
