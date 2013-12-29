angular.module('loomioApp').directive 'startProposal', ->
  restrict: 'E'
  templateUrl: 'generated/templates/start_proposal.html'
  replace: true
  controller: 'StartProposalController'
  link: (scope, element, attrs) ->
    coverRow = element.find('.cover.card-row')
    formRow = element.find('.form.card-row')

    scope.$watch 'isExpanded', (isExpanded) ->
      if isExpanded
        coverRow.addClass('ng-hide')
        formRow.removeClass('ng-hide')
      else
        coverRow.removeClass('ng-hide')
        formRow.addClass('ng-hide')
