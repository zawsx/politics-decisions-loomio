describe 'startProposal directive', ->
  $scope = {}
  element = {}
  form = {}
  fakeInput = {}
  realInput = {}

  beforeEach module 'loomioApp'

  beforeEach inject ($compile, $rootScope) ->
    $scope = $rootScope
    element = $compile('<start_proposal></start_proposal>')($rootScope)
    $rootScope.$digest()

  describe 'by default', ->
    it 'starts in collapsed mode', ->
      expect($scope.isExpanded).toBe(false)

    it 'starts with the form hidden', ->
      expect(element.find('.form')).toHaveClass('ng-hide')

    it 'starts with the cover showing', ->
      expect(element.find('.cover')).not.toHaveClass('ng-hide')
