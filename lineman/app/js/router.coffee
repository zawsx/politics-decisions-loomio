angular.module('loomioApp').config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode(true)

  $routeProvider.when '/discussions/:id',
    templateUrl: 'generated/templates/discussion.html'
    controller: 'DiscussionController'
    resolve:
      discussion: ($route, $http) ->
        $http.get("/api/discussions/#{$route.current.params.id}").then (response)->
          response.data.discussion
  #.when '/',
    #templateUrl: '/templates/hello'
  .otherwise
    redirectTo: '/'