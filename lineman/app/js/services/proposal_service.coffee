angular.module('loomioApp').service 'ProposalService',
  class ProposalService
    constructor: (@$http) ->
    start: (proposal, discussion) ->
      true
