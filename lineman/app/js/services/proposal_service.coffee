angular.module('loomioApp').service 'CommentService',
  class ProposalService
    constructor: (@$http) ->
    start: (proposal, discussion) ->
      true
